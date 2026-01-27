# VHS tape for TUI branch filter modal
# Run with: vhs tui-branch-filter.tape
# Shows pressing 'b' to open the branch filter modal

Output ./output/tui-branch-filter.webm

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

# Press 'b' to open the branch filter modal
Type "b"
Sleep 2s

# Navigate through branches
Down
Sleep 500ms
Down
Sleep 500ms
Down
Sleep 500ms
Down
Sleep 500ms
Up
Sleep 1s

# Select a branch
Enter
Sleep 2s

# Quit
Type "q"
Sleep 500ms
