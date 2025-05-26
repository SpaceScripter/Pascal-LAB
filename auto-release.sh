#!/bin/bash
# auto-release.sh — semantic-version release helper
# (c) 2025 SpaceScripter — CC BY-NC 4.0 Licence
# -------------------------------------------------

set -e  # exit immediately on any error

# ──────────────────────────────────────────────────────────────────────────────
# 0. Parse arguments
# ──────────────────────────────────────────────────────────────────────────────
VERBOSE=false
QUIET=false

# Fun Pack flags (all off by default)
BANNER=false
QUOTE=false
CELEBRATE=false
STYLE=false

for arg in "$@"; do
  case $arg in
    --verbose) VERBOSE=true ;;
    --quiet|--silent) QUIET=true ;;
    # Fun Pack shortcuts and toggles:
    --fun)
      BANNER=true
      QUOTE=true
      CELEBRATE=true
      STYLE=true
      ;;
    --banner) BANNER=true ;;
    --quote) QUOTE=true ;;
    --celebrate) CELEBRATE=true ;;
    --style) STYLE=true ;;
  esac
done

# If quiet, disable fun features
if $QUIET; then
  BANNER=false
  QUOTE=false
  CELEBRATE=false
  STYLE=false
fi

$VERBOSE && set -x

log() {
  if ! $QUIET; then
    echo "$@"
  fi
}

# ──────────────────────────────────────────────────────────────────────────────
# 🎨 Fun Pack Feature: Stylized banner output
# ──────────────────────────────────────────────────────────────────────────────
if $BANNER; then
  BANNER_TEXT="🚀 SpaceScripter Auto Release Tool"
  COLORS=(31 32 33 34 35 36)
  for ((i = 0; i < ${#BANNER_TEXT}; i++)); do
    COLOR=${COLORS[$((i % ${#COLORS[@]}))]}
    printf "\e[1;${COLOR}m${BANNER_TEXT:$i:1}\e[0m"
    sleep 0.02
  done
  echo -e "\n"
fi

# ──────────────────────────────────────────────────────────────────────────────
# 🌌 Fun Pack Feature: Quote of the Day (space-themed)
# ──────────────────────────────────────────────────────────────────────────────
if $QUOTE; then
  QUOTES=(
    "“That’s one small step for man, one giant leap for mankind.” – Neil Armstrong"
    "“To confine our attention to terrestrial matters would be to limit the human spirit.” – Stephen Hawking"
    "“Do or do not. There is no try.” – Yoda"
    "“The Earth is the cradle of humanity, but one cannot live in the cradle forever.” – Tsiolkovsky"
  )
  RANDOM_QUOTE=${QUOTES[$((RANDOM % ${#QUOTES[@]}))]}
  echo -e "\n🌌 \e[1mQuote of the Mission:\e[0m \"$RANDOM_QUOTE\"\n"
fi

# ──────────────────────────────────────────────────────────────────────────────
# 1. Find the latest *semantic* tag in the repository (vMAJOR.MINOR.PATCH)
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

if $STYLE; then
  # Stylized headings
  {
    echo -e "### 📦 \e[1m$TITLE\e[0m"
    echo
    echo -e "**Release Date:** \`$DATE\`  "
    echo -e "**Tag:** \`$NEW_TAG\`  "
    echo -e "**Status:** ✅ Stable  "
    echo -e "**Pushed By:** $PUSHER"
    echo
    echo "---"
    echo
    echo -e "### ✨ \e[1mWhat's New\e[0m"
    echo "- 🔧 $SUMMARY"
    echo
    echo "---"
    echo
    echo -e "### 🧾 \e[1mCommits Since v$LATEST_TAG\e[0m"
    echo "$COMMITS" | sed 's/^/- `/;s/$/`/'
    echo
    echo "---"
    echo
    echo -e "### 📁 \e[1mFiles Affected\e[0m"
    echo "$FILES" | sed 's/^/- `/;s/$/`/'
    echo
    echo "---"
    echo
    echo -e "### 🔍 \e[1mHow to Upgrade\e[0m"
    echo '```bash'
    echo "git pull origin main"
    echo "git fetch --tags"
    echo '```'
    echo
    echo "---"
    echo
    echo -e "### 🗒️ \e[1mNotes\e[0m"
    echo "Open issues/feedback here: <https://github.com/SpaceScripter/Pascal-LAB/issues>"
  } > "$NOTES_FILE"
else
  # Plain text headings
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
fi

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
git push origin main
log "✅  Pushed release notes and removed old notes on GitHub"

# ──────────────────────────────────────────────────────────────────────────────
# 6. Tag and push the new version
# ──────────────────────────────────────────────────────────────────────────────
git tag "$NEW_TAG"
git push origin "$NEW_TAG"
log "✅  Pushed tag $NEW_TAG to GitHub"

# ──────────────────────────────────────────────────────────────────────────────
# 7. Create GitHub Release page if gh CLI is installed
# ──────────────────────────────────────────────────────────────────────────────
if command -v gh >/dev/null 2>&1; then
  gh release create "$NEW_TAG" --title "$TITLE" --notes-file "$NOTES_FILE"
  log "✅  GitHub Release page created"

  # ──────────────────────────────────────────────────────────────────────────────
  # 🎉 Fun Pack Feature: Celebration message after release
  # ──────────────────────────────────────────────────────────────────────────────
  if $CELEBRATE; then
    echo -e "\n🚀 Mission Accomplished, Commander!"
    echo -e "🎉 New version \e[1m$NEW_TAG\e[0m has launched into the GitHub galaxy!\n"
  fi

  # ──────────────────────────────────────────────────────────────────────────────
  # 8. Launch GitHub release page in default browser
  # ──────────────────────────────────────────────────────────────────────────────
  REPO_URL=$(git config --get remote.origin.url | sed -E 's/\.git$//' | sed -E 's/git@github\.com:/https:\/\/github.com\//')
  RELEASE_URL="$REPO_URL/releases/tag/$NEW_TAG"
  log "🌐 Opening $RELEASE_URL"
  open "$RELEASE_URL" 2>/dev/null || xdg-open "$RELEASE_URL" 2>/dev/null || log "⚠️ Could not auto-open browser."
else
  log "ℹ️  GitHub CLI (gh) not found – skipping automatic Release page"
fi