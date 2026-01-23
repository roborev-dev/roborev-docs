# VHS tape for TUI copy to clipboard feature
# Run with: vhs tui-copy.tape
# Shows copying review content to clipboard with 'y' key

Output ./output/tui-copy.gif

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

# Navigate to a completed review
Type "j"
Sleep 500ms

# Enter the review view
Enter
Sleep 2s

# Press 'y' to copy - watch for flash message
Type "y"
Sleep 2s

# Go back to queue
Escape
Sleep 1s

# Copy directly from queue view
Type "y"
Sleep 2s

# Quit
Type "q"
Sleep 500ms
