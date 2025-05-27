#!/bin/bash
# auto-release.sh — semantic-version release helper with Fun Pack 🎉 & GitHub release
# (c) 2025 SpaceScripter — CC BY-NC 4.0 Licence
# -------------------------------------------------

set -e  # exit immediately on any error

# ──────────────────────────────────────────────────────────────────────────────
# Parse arguments
# ──────────────────────────────────────────────────────────────────────────────
FUN_MODE=false
VERBOSE=false
QUIET=false

for arg in "$@"; do
  case $arg in
    --fun) FUN_MODE=true ;;
    --verbose) VERBOSE=true ;;
    --quiet|--silent) QUIET=true ;;
  esac
done

$VERBOSE && set -x

log() {
  if ! $QUIET; then
    echo "$@"
  fi
}

fun_echo() {
  if $FUN_MODE && ! $QUIET; then
    echo -e "\e[1;35m🎉 $1 🎉\e[0m"
  else
    echo "$1"
  fi
}

spinner() {
  local pid=$1
  local delay=0.1
  local spinstr='|/-\'
  while kill -0 $pid 2>/dev/null; do
    local temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
}

random_fun_fact() {
  local facts=(
    "Did you know? The first computer bug was an actual moth found in a computer!"
    "Fun Fact: 'Git' was named by Linus Torvalds, and it means 'unpleasant person' in British slang."
    "Programming Tip: Comment your code like a friendly guide, not a detective!"
    "Did you know? The emoji 🎉 symbolizes celebration, perfect for your release!"
    "Remember: A commit a day keeps the bugs away!"
  )
  local idx=$(( RANDOM % ${#facts[@]} ))
  fun_echo "${facts[$idx]}"
}

# Display random fun fact if fun mode enabled
if $FUN_MODE; then
  random_fun_fact
fi

# ──────────────────────────────────────────────────────────────────────────────
# 1. Find the latest semantic tag (vMAJOR.MINOR.PATCH)
# ──────────────────────────────────────────────────────────────────────────────
LATEST_TAG=$(git tag -l 'v*' | sort -V | tail -n 1)
LATEST_TAG=${LATEST_TAG:-v0.0.0}
LATEST_TAG=${LATEST_TAG#v}
IFS='.' read -r MAJOR MINOR PATCH <<< "$LATEST_TAG"

log "Last version detected: v$LATEST_TAG"
log "What kind of change is this release?"
select CHANGE in "Patch (bug-fix)" "Minor (new feature)" "Major (breaking change)"; do
  case $CHANGE in
    "Patch (bug-fix)")
      PATCH=$((PATCH + 1)); break ;;
    "Minor (new feature)")
      MINOR=$((MINOR + 1)); PATCH=0; break ;;
    "Major (breaking change)")
      MAJOR=$((MAJOR + 1)); MINOR=0; PATCH=0; break ;;
    *) log "Invalid option – choose 1, 2 or 3." ;;
  esac
done

NEW_TAG="v$MAJOR.$MINOR.$PATCH"
TITLE="Release $NEW_TAG"
DATE=$(date +"%Y-%m-%d")

read -rp "Short summary of changes: " SUMMARY
read -rp "Who is pushing this update? " PUSHER

# ──────────────────────────────────────────────────────────────────────────────
# 2. Gather commits & files changed since the previous tag
# ──────────────────────────────────────────────────────────────────────────────
if git rev-parse "v$LATEST_TAG" >/dev/null 2>&1; then
  COMMITS=$(git log "v$LATEST_TAG"..HEAD --oneline)
  FILES=$(git diff --name-only "v$LATEST_TAG"..HEAD)
else
  COMMITS=$(git log --oneline)
  FILES=$(git ls-files)
fi

# ──────────────────────────────────────────────────────────────────────────────
# 3. Generate release notes markdown (with pusher info)
# ──────────────────────────────────────────────────────────────────────────────
NOTES_FILE="release-$NEW_TAG.md"
cat <<EOF > "$NOTES_FILE"
### 📦 $TITLE

**Release Date:** \`$DATE\`  
**Tag:** \`$NEW_TAG\`  
**Status:** ✅ Stable  
**Pushed By:** $PUSHER

---

### ✨ What's New
- 🔧 $SUMMARY

---

### 🧾 Commits Since v$LATEST_TAG
$(echo "$COMMITS" | sed 's/^/- `/;s/$/`/')

---

### 📁 Files Affected
$(echo "$FILES" | sed 's/^/- `/;s/$/`/')

---

### 🔍 How to Upgrade
\`\`\`bash
git pull origin main
git fetch --tags
\`\`\`

---

### 🗒️ Notes
Open issues/feedback here: <https://github.com/SpaceScripter/Pascal-LAB/issues>
EOF

log "✅  Release notes written to $NOTES_FILE"

# ──────────────────────────────────────────────────────────────────────────────
# 4. Remove old release notes files except current and stage deletions
# ──────────────────────────────────────────────────────────────────────────────
log "Removing old release notes files except $NOTES_FILE ..."
shopt -s nullglob
FILES_TO_REMOVE=()
for file in release-*.md; do
  if [[ "$file" != "$NOTES_FILE" ]]; then
    rm -f "$file"
    FILES_TO_REMOVE+=("$file")
    log "Deleted $file"
  fi
done
shopt -u nullglob

# ──────────────────────────────────────────────────────────────────────────────
# 5. Stage new release notes and removals, commit and push
# ──────────────────────────────────────────────────────────────────────────────
git add "$NOTES_FILE"

if [ ${#FILES_TO_REMOVE[@]} -gt 0 ]; then
  git rm "${FILES_TO_REMOVE[@]}"
fi

git commit -m "Chore: update release notes for $NEW_TAG by $PUSHER (remove old notes)"

fun_echo "Pushing release notes and cleanup to GitHub..."
(git push origin main &) & spinner $!

# ──────────────────────────────────────────────────────────────────────────────
# 6. Tag and push the new version
# ──────────────────────────────────────────────────────────────────────────────
git tag "$NEW_TAG"

fun_echo "Pushing tag $NEW_TAG to GitHub..."
(git push origin "$NEW_TAG" &) & spinner $!

# ──────────────────────────────────────────────────────────────────────────────
# 7. Create GitHub Release page if gh CLI is installed
# ──────────────────────────────────────────────────────────────────────────────
if command -v gh >/dev/null 2>&1; then
  fun_echo "Creating GitHub Release page for $NEW_TAG..."
  (gh release create "$NEW_TAG" --title "$TITLE" --notes-file "$NOTES_FILE" &) & spinner $!
  fun_echo "Release page created! 🎊"

  # ──────────────────────────────────────────────────────────────────────────────
  # 8. Launch GitHub release page in default browser
  # ──────────────────────────────────────────────────────────────────────────────
  REPO_URL=$(git config --get remote.origin.url | sed -E 's/\.git$//' | sed -E 's/git@github\.com:/https:\/\/github.com\//')
  RELEASE_URL="$REPO_URL/releases/tag/$NEW_TAG"
  fun_echo "🌐 Opening $RELEASE_URL"
  open "$RELEASE_URL" 2>/dev/null || xdg-open "$RELEASE_URL" 2>/dev/null || log "⚠️ Could not auto-open browser."
else
  log "ℹ️  GitHub CLI (gh) not found – skipping automatic Release page"
fi

# ──────────────────────────────────────────────────────────────────────────────
# Final Fun Quotes if enabled
# ──────────────────────────────────────────────────────────────────────────────
if $FUN_MODE; then
  quotes=(
    "Keep calm and commit on! 🚀"
    "Code hard, ship easy! 🎯"
    "One more release, one step closer to world domination! 🌍"
    "Celebrate good code, come on! 🎶"
  )
  idx=$(( RANDOM % ${#quotes[@]} ))
  fun_echo "${quotes[$idx]}"
fi