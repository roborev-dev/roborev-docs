# VHS tape for TUI repo filter modal
# Run with: vhs tui-filter.tape
# Shows pressing 'f' to open the repository filter modal

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

# Launch roborev tui
Type "roborev tui"
Enter
Sleep 2s

# Press 'f' to open the repo filter modal
Type "f"
Sleep 2s

# Navigate through repos
Down
Sleep 500ms
Down
Sleep 500ms
Up
Sleep 1s

# Select a repo
Enter
Sleep 2s

# Quit
Type "q"
Sleep 500ms
