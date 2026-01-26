# VHS tape for TUI commit message viewer demo
# Run with: vhs tui-commit-message.tape
# Prerequisite: ./prepare-demo-db.sh

Output ./output/tui-commit-message.webm

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

# View commit message from queue with 'm'
Type "m"
Sleep 3s

# Close commit message
Escape
Sleep 1s

# Enter review view
Enter
Sleep 2s

# View commit message from review view
Type "m"
Sleep 3s

# Close commit message
Escape
Sleep 1s

# Back to queue
Escape
Sleep 500ms

# Quit
Type "q"
Sleep 500ms
