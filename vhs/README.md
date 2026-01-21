# VHS Screenshot Generation

This directory contains [VHS](https://github.com/charmbracelet/vhs) tape files for generating animated GIF screenshots of the roborev TUI.

## Requirements

```bash
brew install vhs
```

## Setup Demo Database

The tapes use an isolated demo database containing only roborev reviews (no private data from other repos).

```bash
cd docs/vhs
./prepare-demo-db.sh
```

This creates `demo-data/reviews.db` with only roborev-related reviews extracted from your main database. The demo-data directory is gitignored.

## Generate Screenshots

```bash
cd docs/vhs

# Generate a specific screenshot
vhs tui-filter.tape

# Or generate all
for tape in *.tape; do vhs "$tape"; done
```

## Output

Screenshots are output to `../src/assets/screenshots/` as GIF files.

Note: VHS supports GIF, WebM, MP4, and PNG output (not SVG).
