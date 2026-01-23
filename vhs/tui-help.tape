# VHS tape for TUI help screen
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


# Launch roborev tui
Type "roborev tui"
Enter
Sleep 2s

# Show help with '?'
Type "?"
Sleep 4s

# Close help
Escape
Sleep 1s

# Quit
Type "q"
Sleep 500ms
