# Auto Release Script v5.3.0

Semantic versioning release helper script with optional Fun Pack features and improved logging.

---

## Features

- **Semantic version detection**: Automatically find last `vMAJOR.MINOR.PATCH` tag and increment based on your choice (Patch, Minor, Major).
- **Interactive release notes**: Prompts for short summary and pusher name.
- **Auto-generated Markdown release notes** with:
  - Release info (version, date, pusher)
  - Commit list since last release
  - Files changed since last release
  - Upgrade instructions
  - Notes with GitHub issues link
- **Old release notes cleanup**: Automatically removes previous release notes files.
- **Git commit & push**: Adds new notes, removes old ones, commits, tags, and pushes to remote.
- **Fun Pack features** (selectable):
  - Auto-launch GitHub release page after pushing
  - Auto-launch custom release website URL after pushing
  - Verbose bash output logging
- **Flexible logging**:
  - `--verbose` for detailed command tracing
  - `--quiet` or `--silent` for minimal output

---

## Usage

```bash
./auto-release.sh [--verbose] [--quiet|--silent]