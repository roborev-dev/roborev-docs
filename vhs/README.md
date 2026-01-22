# VHS Screenshot Generation

This directory contains [VHS](https://github.com/charmbracelet/vhs) tape files for generating animated GIF screenshots of the roborev TUI and CLI.

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
| `tui-filter.tape` | Hero banner GIF - TUI filtering demo | `public/tui-filter.gif` |
| `tui-navigation.tape` | Basic TUI navigation (j/k, enter, escape, help) | `public/tui-navigation.gif` |
| `tui-queue.tape` | Queue view with pending reviews | `public/tui-queue.gif` |
| `tui-review.tape` | Review detail view with findings | `public/tui-review.gif` |
| `tui-address.tape` | Addressing findings workflow | `public/tui-address.gif` |
| `tui-respond.tape` | Respond modal for adding comments | `public/tui-respond.gif` |
| `tui-help.tape` | Help screen overlay | `public/tui-help.gif` |

### CLI Demos
| Tape | Description | Output |
|------|-------------|--------|
| `cli-help.tape` | CLI help output | `public/cli-help.gif` |
| `cli-version.tape` | Version output | `public/cli-version.gif` |
| `cli-status.tape` | Status output | `public/cli-status.gif` |
| `cli-repo-list.tape` | Repo list and details | `public/cli-repo-list.gif` |
| `commands-status.tape` | Combined version/status/help | `public/commands-status.gif` |

### Workflow Demos (require git repo setup)
| Tape | Description | Output |
|------|-------------|--------|
| `quickstart-demo.tape` | Fresh install, init, first review | `public/quickstart-demo.gif` |
| `branch-review.tape` | Reviewing feature branches | `public/branch-review.gif` |
| `refine-loop.tape` | Auto-fix cycle demo | `public/refine-loop.gif` |

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

Screenshots are output to `../public/` as GIF files and are served directly by the docs site.

Note: VHS supports GIF, WebM, MP4, and PNG output (not SVG).
