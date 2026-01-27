# VHS tape for TUI keyboard help modal demo
# Run with: vhs tui-help.tape
# Prerequisite: ./prepare-demo-db.sh

Output ./output/tui-help.webm

# Terminal settings
Set TypingSpeed 50ms
Set Theme "Dracula"
Set FontFamily "MesloLGS NF"
Set FontSize 16
Set Width 1200
Set Height 600
Set Padding 20
Set Framerate 25


# Launch roborev tui (hidden)
Hide
Type "roborev tui"
Enter
Sleep 1s
Show
Sleep 2s

# Show help modal with '?'
Type "?"
Sleep 3s

# Close help modal
Escape
Sleep 1s

# Navigate to a review
Enter
Sleep 2s

# Show help in review view
Type "?"
Sleep 3s

# Close help
Escape
Sleep 1s

# Back to queue
Escape
Sleep 500ms

# Quit
Type "q"
Sleep 500ms
