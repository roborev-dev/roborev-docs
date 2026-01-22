# VHS tape for TUI review detail view
# Run with: vhs tui-review.tape
# Prerequisite: ./prepare-demo-db.sh

Output ./output/tui-review.gif

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

# Enter first review
Enter
Sleep 2s

# Scroll through the review content
Down
Sleep 300ms
Down
Sleep 300ms
Down
Sleep 300ms
Down
Sleep 300ms
Down
Sleep 300ms
Sleep 1s

# Scroll back up
Up
Sleep 300ms
Up
Sleep 300ms
Up
Sleep 2s

# Go back and quit
Escape
Sleep 500ms
Type "q"
Sleep 500ms
