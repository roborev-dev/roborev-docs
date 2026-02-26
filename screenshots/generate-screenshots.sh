#!/usr/bin/env bash
# Runs inside the Docker container. Drives tmux + freeze to produce SVG screenshots.
set -euo pipefail

OUTPUT_DIR="${1:-/output}"
FREEZE_CFG="/screenshots/freeze.json"
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

# --- Start tmux session (tall for hero, resized later) ---
tmux -f /dev/null new-session -d -s "$SESSION" -x 120 -y 50
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
for i in $(seq 1 60); do
    status_out=$(roborev status 2>&1 || true)
    if printf '%s' "$status_out" | grep -q 'Daemon:.*running'; then
        daemon_ready=true
        break
    fi
    sleep 0.5
done
if [[ "$daemon_ready" != "true" ]]; then
    echo "ERROR: daemon did not become ready within 30s"
    echo "  roborev status output:"
    roborev status 2>&1 || true
    exit 1
fi

send "roborev tui" Enter
wait_until "Queue"
sleep 0.5

# 1. Hero (taller window for landing page)
capture "tui-hero"

# Resize to standard 40 rows for remaining screenshots
tmux resize-window -t "$SESSION" -x 120 -y 40
sleep 1

# 2. Queue view (standard size)
capture "tui-queue"

# 3. Address: toggle addressed on first job
send "a"
sleep 0.5
capture "tui-address"
send "a"
sleep 0.3

# 4. Review detail view: navigate down and open
send "j"
sleep 0.3
send "Enter"
wait_until "Review"
sleep 0.5
capture "tui-review"

# 5. Copy: press y to copy review to clipboard
send "y"
sleep 0.5
capture "tui-copy"

# 6. Comment modal: press c to open
send "c"
sleep 0.5
capture "tui-respond"
send "Escape"
sleep 0.3

# 7. Help overlay: press ? from review view
send "?"
sleep 0.5
capture "tui-help"

# Close help, back to queue, quit
send "?"
sleep 0.3
send "q"
sleep 0.3
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

# Clear and capture roborev help
send "clear" Enter
sleep 0.5
send "roborev help" Enter
wait_until "Available Commands"
sleep 0.5
capture "cli-help"

# Clear and capture roborev repo list
send "clear" Enter
sleep 0.5
send "roborev repo list" Enter
wait_until "NAME"
sleep 0.5
capture "cli-repo-list"

# Cleanup
tmux kill-session -t "$SESSION" 2>/dev/null || true

echo ""
echo "Done! Generated $CAPTURED SVG files in $OUTPUT_DIR"
