# VHS tape for TUI queue view screenshot
# Run with: vhs tui-queue.tape
# Prerequisite: ./prepare-demo-db.sh

Output ./output/tui-queue.webm

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

# Navigate through queue to show multiple items
Down
Sleep 400ms
Down
Sleep 400ms
Down
Sleep 400ms
Down
Sleep 400ms
Up
Sleep 400ms
Up
Sleep 2s

# Quit
Type "q"
Sleep 500ms
