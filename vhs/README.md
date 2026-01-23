# VHS Screenshot Generation

This directory contains [VHS](https://github.com/charmbracelet/vhs) tape files for generating animated WebM videos of the roborev TUI and CLI.

## Requirements

```bash
brew install vhs
```

## Setup Demo Database

The tapes use an isolated demo database containing only roborev reviews (no private data from other repos).

```bash
cd vhs
./prepare-demo-db.sh
```

This creates `demo-data/reviews.db` with only roborev-related reviews extracted from your main database. The demo-data directory is gitignored.

## Available Tapes

### TUI Demos
| Tape | Description | Output |
|------|-------------|--------|
| `tui-filter.tape` | Hero banner - TUI filtering demo | `public/tui-filter.webm` |
| `tui-navigation.tape` | Basic TUI navigation (j/k, enter, escape, help) | `public/tui-navigation.webm` |
| `tui-queue.tape` | Queue view with pending reviews | `public/tui-queue.webm` |
| `tui-review.tape` | Review detail view with findings | `public/tui-review.webm` |
| `tui-address.tape` | Addressing findings workflow | `public/tui-address.webm` |
| `tui-respond.tape` | Respond modal for adding comments | `public/tui-respond.webm` |
| `tui-help.tape` | Help screen overlay | `public/tui-help.webm` |

### CLI Demos
| Tape | Description | Output |
|------|-------------|--------|
| `cli-help.tape` | CLI help output | `public/cli-help.webm` |
| `cli-version.tape` | Version output | `public/cli-version.webm` |
| `cli-status.tape` | Status output | `public/cli-status.webm` |
| `cli-repo-list.tape` | Repo list and details | `public/cli-repo-list.webm` |
| `commands-status.tape` | Combined version/status/help | `public/commands-status.webm` |

### Workflow Demos (require git repo setup)
| Tape | Description | Output |
|------|-------------|--------|
| `quickstart-demo.tape` | Fresh install, init, first review | `public/quickstart-demo.webm` |
| `branch-review.tape` | Reviewing feature branches | `public/branch-review.webm` |
| `refine-loop.tape` | Auto-fix cycle demo | `public/refine-loop.webm` |

## Generate Screenshots

### Using the generate-all script (recommended)

The script builds a Docker image from the roborev repo and runs the daemon in a container for complete isolation.

```bash
cd vhs

# Generate all tapes (builds Docker image, runs daemon in container)
./generate-all.sh

# Generate a specific tape
./generate-all.sh --tape tui-filter

# List available tapes
./generate-all.sh --list

# Use a different roborev repo location
ROBOREV_REPO=/path/to/roborev ./generate-all.sh
```

By default, it looks for the roborev repo at `../../roborev` (sibling to roborev-docs).

### Manual generation

```bash
cd vhs

# Generate a specific screenshot
vhs tui-filter.tape
```

## Settings

All tapes use consistent settings:
- **TypingSpeed**: 200ms
- **Framerate**: 25
- **Theme**: Dracula
- **Font**: MesloLGS NF at 32px
- **Resolution**: 2000x1600 (or 2000x1200 for shorter demos)

## Output

Videos are output to `../public/` as WebM files and are served directly by the docs site. WebM is used instead of GIF for reliable autoplay on mobile browsers.

Note: VHS supports GIF, WebM, MP4, and PNG output (not SVG).
