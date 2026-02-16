# VHS tape for TUI tree filter with branches expanded
# Run with: vhs tui-branch-filter.tape
# Shows pressing 'b' to open the filter with branches pre-expanded,
# then using search to find a branch.

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

# Press 'b' to open the filter with branches expanded
Type "b"
Sleep 1.5s

# Type a search query to filter branches
Type "feat"
Sleep 2s

# Navigate search results
Down
Sleep 500ms
Down
Sleep 500ms
Up
Sleep 1s

# Select the matching branch
Enter
Sleep 2s

# Clear the filter with Esc
Escape
Sleep 1.5s

# Quit
Type "q"
Sleep 500ms
