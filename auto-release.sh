#!/bin/bash
# auto-release.sh — semantic-version release helper
# (c) 2025 SpaceScripter — CC BY-NC 4.0 Licence
# -------------------------------------------------

set -e  # exit immediately on any error

# ──────────────────────────────────────────────────────────────────────────────
# 1. Find the latest *semantic* tag in the repository (vMAJOR.MINOR.PATCH)
# ──────────────────────────────────────────────────────────────────────────────
LATEST_TAG=$(git tag -l 'v*' | sort -V | tail -n 1)   # e.g. v2.1.0
LATEST_TAG=${LATEST_TAG:-v0.0.0}                      # default if no tags yet
LATEST_TAG=${LATEST_TAG#v}                            # strip leading "v"
IFS='.' read -r MAJOR MINOR PATCH <<< "$LATEST_TAG"   # split into numbers

echo "Last version detected: v$LATEST_TAG"
echo "What kind of change is this release?"
select CHANGE in "Patch (bug-fix)" "Minor (new feature)" "Major (breaking change)"; do
  case $CHANGE in
    "Patch (bug-fix)")
      PATCH=$((PATCH + 1));          break ;;
    "Minor (new feature)")
      MINOR=$((MINOR + 1)); PATCH=0; break ;;
    "Major (breaking change)")
      MAJOR=$((MAJOR + 1)); MINOR=0; PATCH=0; break ;;
    *) echo "Invalid option – choose 1, 2 or 3." ;;
  esac
done

NEW_TAG="v$MAJOR.$MINOR.$PATCH"
TITLE="Release $NEW_TAG"
DATE=$(date +"%Y-%m-%d")

read -rp "Short summary of changes: " SUMMARY

# New prompt: who pushed the update
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

echo "✅  Release notes written to $NOTES_FILE"

# ──────────────────────────────────────────────────────────────────────────────
# 4. Remove old release notes files except current and stage deletions
# ──────────────────────────────────────────────────────────────────────────────
echo "Removing old release notes files except $NOTES_FILE ..."
shopt -s nullglob
FILES_TO_REMOVE=()
for file in release-*.md; do
  if [[ "$file" != "$NOTES_FILE" ]]; then
    rm -f "$file"
    FILES_TO_REMOVE+=("$file")
    echo "Deleted $file"
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
echo "✅  Pushed release notes and removed old notes on GitHub"

# ──────────────────────────────────────────────────────────────────────────────
# 6. Tag and push the new version
# ──────────────────────────────────────────────────────────────────────────────
git tag "$NEW_TAG"
git push origin "$NEW_TAG"
echo "✅  Pushed tag $NEW_TAG to GitHub"

# ──────────────────────────────────────────────────────────────────────────────
# 7. Create GitHub Release page if gh CLI is installed
# ──────────────────────────────────────────────────────────────────────────────
if command -v gh >/dev/null 2>&1; then
  gh release create "$NEW_TAG" --title "$TITLE" --notes-file "$NOTES_FILE"
  echo "✅  GitHub Release page created"
else
  echo "ℹ️  GitHub CLI (gh) not found – skipping automatic Release page"
fi
