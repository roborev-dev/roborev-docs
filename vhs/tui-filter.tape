# VHS tape for TUI unified tree filter
# Run with: vhs tui-filter.tape
# Shows pressing 'f' to open the tree filter, expanding a repo,
# navigating branches, and selecting a filter.

Output ./output/tui-filter.webm

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

# Press 'f' to open the unified tree filter
Type "f"
Sleep 1.5s

# Navigate repos
Down
Sleep 500ms

# Expand repo to show branches
Right
Sleep 1.5s

# Navigate branches
Down
Sleep 500ms
Down
Sleep 500ms
Up
Sleep 1s

# Select a branch filter
Enter
Sleep 2s

# Quit
Type "q"
Sleep 500ms
