#!/usr/bin/env bash
# Runs inside the Docker container. Drives tmux + freeze to produce SVG screenshots.
set -euo pipefail

OUTPUT_DIR="${1:-/output}"
FREEZE_CFG="/tapes/freeze.json"
SESSION="rr"

mkdir -p "$OUTPUT_DIR"

# Helper: capture current tmux pane to SVG via freeze
capture() {
    local name="$1"
    tmux capture-pane -pet "$SESSION" | freeze -o "$OUTPUT_DIR/${name}.svg" --language ansi -c "$FREEZE_CFG"
    echo "  captured $name.svg"
}

# Helper: send keys and wait
send() {
    tmux send-keys -t "$SESSION" "$@"
}

# Helper: poll tmux pane (plain text, no ANSI) until a pattern appears (or timeout)
wait_until() {
    local pattern="$1"
    local timeout="${2:-30}"
    local elapsed=0
    while ! tmux capture-pane -pt "$SESSION" | grep -q "$pattern"; do
        sleep 0.5
        elapsed=$((elapsed + 1))
        if [[ $elapsed -ge $((timeout * 2)) ]]; then
            echo "  WARNING: timed out waiting for pattern: $pattern"
            return 1
        fi
    done
}

# --- Start tmux session ---
tmux -f /dev/null start-server
tmux set-option -g default-terminal "tmux-256color"
tmux set-option -ga terminal-overrides ",*:Tc"
tmux new-session -d -s "$SESSION" -x 120 -y 40
tmux send-keys -t "$SESSION" "export COLORTERM=truecolor" Enter
sleep 0.3

# =====================
# TUI Screenshots
# =====================
echo "==> TUI screenshots"

# Start the daemon in the background
send "roborev daemon run &" Enter
sleep 2

send "roborev tui" Enter
wait_until "Queue"
sleep 0.5

# 1. Queue view (default)
capture "tui-queue"

# TODO: Add more TUI screenshots here as needed:
# - tui-review (review detail view)
# - tui-filter (repository filter modal)
# - tui-branch-filter (branch filter modal)
# - tui-help (keyboard shortcuts overlay)
# - tui-address (addressing findings)
# - tui-respond (comment modal)
# - tui-navigation (basic navigation)

# Quit TUI
send "q"
sleep 1

# =====================
# CLI Screenshots
# =====================
echo "==> CLI screenshots"

# Set up a clean prompt
send "export PS1='$ '" Enter
sleep 0.3
send "clear" Enter
sleep 0.5

# 1. roborev status
send "roborev status" Enter
wait_until "Status"
sleep 0.5
capture "cli-status"

# Cleanup
tmux kill-session -t "$SESSION" 2>/dev/null || true

echo ""
echo "Done! Generated $(ls "$OUTPUT_DIR"/*.svg 2>/dev/null | wc -l) SVG files in $OUTPUT_DIR"
