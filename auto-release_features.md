# auto-release.sh Features & Command Line Options

This document summarizes all the command-line options available in the `auto-release.sh` release helper script, including verbosity controls and fun pack features.

---

## Core Flags

| Flag           | Description                                                     |
|----------------|-----------------------------------------------------------------|
| `--verbose`    | Enables verbose mode: shows detailed command execution output   |
|                | (`set -x` shell option enabled)                                 |
| `--quiet` or `--silent` | Disables all script output including fun features       |
|                | Runs the script silently for clean execution                    |

---

## Fun Pack Features & Commands

| Feature               | Description                                               | Command Line Option(s)          |
|-----------------------|-----------------------------------------------------------|--------------------------------|
| 🎨 **Stylized Banner** | Displays a colorful animated banner at script start       | `--banner`                     |
|                       | Enables a rainbow-colored banner animation                 |                                |
|                       |                                                             |                                |
| 🌌 **Quote of the Day**| Shows a random space-themed inspirational quote            | `--quote`                      |
|                       | Prints a random motivational quote about space/science     |                                |
|                       |                                                             |                                |
| 🎉 **Celebrate Release** | Prints a fun celebration message after a successful release | `--celebrate`                  |
|                       | Shows congratulatory emojis and new version number         |                                |
|                       |                                                             |                                |
| ✍️ **Stylized Markdown** | Adds color and emoji formatting to release notes          | `--style`                     |
|                       | Produces visually enhanced markdown for better readability |                                |
|                       |                                                             |                                |
| ⚡ **All Fun Features**  | Enables all fun pack features at once                     | `--fun`                        |
|                       | Shortcut to turn on banner, quote, celebrate, and style    |                                |

---

## Usage Examples

- Enable verbose output with all fun features:

  ```bash
  ./auto-release.sh --verbose --fun