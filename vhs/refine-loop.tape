# VHS tape for refine/auto-fix loop demo
# Run with: vhs refine-loop.tape
# Prerequisite: Git repo with a review that has addressable findings
#
# Setup required:
#   - Have a review with findings ready in the demo database
#   - Findings should be auto-fixable (code issues, not design)

Output ./output/refine-loop.webm

# Terminal settings
Set TypingSpeed 50ms
Set Theme "Dracula"
Set FontFamily "MesloLGS NF"
Set FontSize 16
Set Width 1200
Set Height 600
Set Padding 20
Set Framerate 25

# Connect to daemon running in Docker
Env ROBOREV_DATA_DIR "./demo-data"

# Show current review status
Type "roborev status"
Enter
Sleep 3s

# Open TUI
Type "roborev tui"
Enter
Sleep 2s

# Navigate to a review with findings
Type "j"
Sleep 500ms
Enter
Sleep 2s

# Navigate to a finding
Type "j"
Sleep 500ms
Enter
Sleep 3s

# Address the finding with 'a' key
Type "a"
Sleep 5s

# Show the auto-fix in progress
Sleep 3s

# Review the fix
Sleep 4s

# Accept the fix
Enter
Sleep 2s

# Show the finding is now resolved
Sleep 3s

# Quit
Type "q"
Sleep 500ms
