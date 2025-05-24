#!/bin/bash

set -e

LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
LATEST_TAG=${LATEST_TAG#v}

IFS='.' read -r MAJOR MINOR PATCH <<< "$LATEST_TAG"

echo "Last version: v$LATEST_TAG"
echo "What kind of change is this?"
select CHANGE in "Patch (bugfix)" "Minor (new feature)" "Major (breaking change)"; do
  case $CHANGE in
    "Patch (bugfix)")
      PATCH=$((PATCH + 1))
      break
      ;;
    "Minor (new feature)")
      MINOR=$((MINOR + 1))
      PATCH=0
      break
      ;;
    "Major (breaking change)")
      MAJOR=$((MAJOR + 1))
      MINOR=0
      PATCH=0
      break
      ;;
    *)
      echo "Invalid option."
      ;;
  esac
done

NEW_TAG="v$MAJOR.$MINOR.$PATCH"
TITLE="Release $NEW_TAG"
DATE=$(date +"%Y-%m-%d")

read -p "Summary of changes: " SUMMARY

COMMITS=$(git log "$LATEST_TAG"..HEAD --oneline || git log --oneline)
FILES=$(git diff --name-only "$LATEST_TAG"..HEAD || git ls-files)

FILENAME="release-$NEW_TAG.md"
cat <<EOF > "$FILENAME"
### 📦 $TITLE

**Release Date:** \`$DATE\`  
**Tag:** \`$NEW_TAG\`  
**Status:** ✅ Stable

---

### ✨ What's New

- 🔧 $SUMMARY

---

### 🧾 Commits Since $LATEST_TAG

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

Let us know if you find any issues — open an [issue here](https://github.com/SpaceScripter/Pascal-LAB/issues).
EOF

echo "✅ Release notes written to $FILENAME"

git tag "$NEW_TAG"
git push origin "$NEW_TAG"
echo "✅ Tag $NEW_TAG pushed to GitHub"

if command -v gh &> /dev/null; then
  gh release create "$NEW_TAG" --title "$TITLE" --notes-file "$FILENAME"
  echo "✅ GitHub release created"
else
  echo "ℹ️  GitHub CLI (gh) not installed — skipping GitHub release"
fi
