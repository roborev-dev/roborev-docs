# VHS tape for TUI navigation demo
# Run with: vhs tui-navigation.tape
# Prerequisite: ./prepare-demo-db.sh

Output ./output/tui-navigation.webm

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

# Navigate down through the queue with j/k
Down
Sleep 500ms
Down
Sleep 500ms
Down
Sleep 500ms
Up
Sleep 500ms

# Open filter modal with 'f'
Type "f"
Sleep 1.5s

# Close filter modal
Escape
Sleep 1s

# Enter a review to view details
Enter
Sleep 2s

# Scroll down in review
Down
Sleep 300ms
Down
Sleep 300ms
Down
Sleep 300ms

# Go back to queue
Escape
Sleep 1s

# Show help with '?'
Type "?"
Sleep 2s

# Close help
Escape
Sleep 1s

# Quit
Type "q"
Sleep 500ms
