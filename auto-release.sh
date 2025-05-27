#!/bin/bash
# auto-release.sh — semantic-version release helper with Fun Pack features
# (c) 2025 SpaceScripter — CC BY-NC 4.0 Licence
# -------------------------------------------------

set -e  # exit immediately on any error

# ──────────────────────────────────────────────────────────────────────────────
# 0. Parse arguments
# ──────────────────────────────────────────────────────────────────────────────
VERBOSE=false
QUIET=false

for arg in "$@"; do
  case $arg in
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
# 1.5 Choose Fun Pack features to include
# ──────────────────────────────────────────────────────────────────────────────
echo
log "Select additional Fun Pack features to include (enter numbers separated by spaces):"
echo "  1) Auto-launch GitHub release page in browser"
echo "  2) Auto-launch release website (enter URL next)"
echo "  3) Enable verbose logging (--verbose)"
echo "  0) None"
read -rp "Your choices: " FUN_CHOICES

AUTO_LAUNCH_RELEASE_PAGE=false
AUTO_LAUNCH_WEBSITE=false

for choice in $FUN_CHOICES; do
  case $choice in
    1) AUTO_LAUNCH_RELEASE_PAGE=true ;;
    2) 
       AUTO_LAUNCH_WEBSITE=true
       read -rp "Enter the release website URL to auto-launch: " RELEASE_WEBSITE_URL
       ;;
    3) 
       VERBOSE=true
       set -x
       ;;
    0) ;;
    *) log "Ignoring invalid choice: $choice" ;;
  esac
done

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
# 3. Generate release notes markdown (with pusher info) — clean markdown
# ──────────────────────────────────────────────────────────────────────────────
NOTES_FILE="release-$NEW_TAG.md"
cat <<EOF > "$NOTES_FILE"
# 📦 Release $NEW_TAG

**Release Date:** \`$DATE\`  
**Tag:** \`$NEW_TAG\`  
**Status:** ✅ Stable  
**Pushed By:** $PUSHER

---

## ✨ What's New
- 🔧 $SUMMARY

---

## 🧾 Commits Since v$LATEST_TAG
\`\`\`
$COMMITS
\`\`\`

---

## 📁 Files Affected
\`\`\`
$FILES
\`\`\`

---

## 🔍 How to Upgrade
\`\`\`bash
git pull origin main
git fetch --tags
\`\`\`

---

## 🗒️ Notes
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
git push origin main
log "✅  Pushed release notes and removed old notes on GitHub"

# ──────────────────────────────────────────────────────────────────────────────
# 6. Tag and push the new version
# ──────────────────────────────────────────────────────────────────────────────
git tag "$NEW_TAG"
git push origin "$NEW_TAG"
log "✅  Pushed tag $NEW_TAG to GitHub"

# ──────────────────────────────────────────────────────────────────────────────
# 7. Optional: Auto-launch GitHub Release page
# ──────────────────────────────────────────────────────────────────────────────
if $AUTO_LAUNCH_RELEASE_PAGE; then
  REPO_URL=$(git config --get remote.origin.url | sed -E 's/\.git$//' | sed -E 's/git@github\.com:/https:\/\/github.com\//')
  RELEASE_URL="$REPO_URL/releases/tag/$NEW_TAG"
  log "🌐 Opening GitHub Release page: $RELEASE_URL"
  open "$RELEASE_URL" 2>/dev/null || xdg-open "$RELEASE_URL" 2>/dev/null || log "⚠️ Could not auto-open browser."
fi

# ──────────────────────────────────────────────────────────────────────────────
# 8. Optional: Auto-launch release website URL
# ──────────────────────────────────────────────────────────────────────────────
if $AUTO_LAUNCH_WEBSITE; then
  log "🌐 Opening release website URL: $RELEASE_WEBSITE_URL"
  open "$RELEASE_WEBSITE_URL" 2>/dev/null || xdg-open "$RELEASE_WEBSITE_URL" 2>/dev/null || log "⚠️ Could not auto-open release website."
fi

log "🎉 Release $NEW_TAG complete!"