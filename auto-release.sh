#!/bin/bash
# auto-release.sh — semantic-version release helper
# (c) 2025 SpaceScripter — MIT Licence

set -e  # exit immediately on any error

# 1. Get the latest semantic tag
LATEST_TAG=$(git tag -l 'v*' | sort -V | tail -n 1)
LATEST_TAG=${LATEST_TAG:-v0.0.0}
LATEST_TAG=${LATEST_TAG#v}
IFS='.' read -r MAJOR MINOR PATCH <<< "$LATEST_TAG"

echo "Last version detected: v$LATEST_TAG"
echo "What kind of change is this release?"
select CHANGE in "Patch (bug-fix)" "Minor (new feature)" "Major (breaking change)"; do
  case $CHANGE in
    "Patch (bug-fix)") PATCH=$((PATCH + 1)); break ;;
    "Minor (new feature)") MINOR=$((MINOR + 1)); PATCH=0; break ;;
    "Major (breaking change)") MAJOR=$((MAJOR + 1)); MINOR=0; PATCH=0; break ;;
    *) echo "Invalid option – choose 1, 2 or 3." ;;
  esac
done

NEW_TAG="v$MAJOR.$MINOR.$PATCH"
TITLE="Release $NEW_TAG"
DATE=$(date +"%Y-%m-%d")

read -rp "Short summary of changes: " SUMMARY

# 2. Gather commits and files changed since last tag
if git rev-parse "v$LATEST_TAG" >/dev/null 2>&1; then
  COMMITS=$(git log "v$LATEST_TAG"..HEAD --oneline)
  FILES=$(git diff --name-only "v$LATEST_TAG"..HEAD)
else
  COMMITS=$(git log --oneline)
  FILES=$(git ls-files)
fi

# 3. Generate release notes markdown
NOTES_FILE="release-$NEW_TAG.md"
cat <<EOF > "$NOTES_FILE"
### 📦 $TITLE

**Release Date:** \`$DATE\`  
**Tag:** \`$NEW_TAG\`  
**Status:** ✅ Stable

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

# 4. Delete old release-*.md files except the current one
echo "Deleting old release notes files except $NOTES_FILE ..."
shopt -s nullglob
for file in release-*.md; do
  if [[ "$file" != "$NOTES_FILE" ]]; then
    rm -f "$file"
    echo "Deleted $file"
  fi
done
shopt -u nullglob

# 5. Commit and push the new release notes file BEFORE tagging
git add "$NOTES_FILE"
git commit -m "Chore: add release notes for $NEW_TAG"
git push origin main
echo "✅  Pushed release notes for $NEW_TAG to GitHub"

# 6. Tag and push the new version
git tag "$NEW_TAG"
git push origin "$NEW_TAG"
echo "✅  Pushed tag $NEW_TAG to GitHub"

# 7. Create GitHub release page if 'gh' CLI exists
if command -v gh >/dev/null 2>&1; then
  gh release create "$NEW_TAG" --title "$TITLE" --notes-file "$NOTES_FILE"
  echo "✅  GitHub Release page created"
else
  echo "ℹ️  GitHub CLI (gh) not found – skipping automatic Release page"
fi
