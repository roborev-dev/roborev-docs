#!/usr/bin/env bash
# Runs inside the Docker container. Drives tmux + freeze to produce SVG screenshots.
set -euo pipefail

OUTPUT_DIR="${1:-/output}"
FREEZE_CFG="/tapes/freeze.json"
SESSION="rr"
CAPTURED=0

mkdir -p "$OUTPUT_DIR"

# Helper: capture current tmux pane to SVG via freeze
capture() {
    local name="$1"
    tmux capture-pane -pet "$SESSION" | freeze -o "$OUTPUT_DIR/${name}.svg" --language ansi -c "$FREEZE_CFG"
    CAPTURED=$((CAPTURED + 1))
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
tmux -f /dev/null new-session -d -s "$SESSION" -x 120 -y 40
tmux set-option -g default-terminal "tmux-256color"
tmux set-option -ga terminal-overrides ",*:Tc"
tmux send-keys -t "$SESSION" "export COLORTERM=truecolor" Enter
sleep 0.3

# =====================
# TUI Screenshots
# =====================
echo "==> TUI screenshots"

# Start the daemon in the background and wait for it to be ready
send "roborev daemon run &" Enter
daemon_ready=false
for i in $(seq 1 30); do
    if roborev status 2>/dev/null | grep -qE '^Daemon:\s+running\b'; then
        daemon_ready=true
        break
    fi
    sleep 0.5
done
if [[ "$daemon_ready" != "true" ]]; then
    echo "ERROR: daemon did not become ready within 15s"
    exit 1
fi

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
echo "Done! Generated $CAPTURED SVG files in $OUTPUT_DIR"
