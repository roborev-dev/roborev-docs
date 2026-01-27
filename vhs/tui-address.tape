# VHS tape for TUI address findings workflow
# Run with: vhs tui-address.tape
# Prerequisite: ./prepare-demo-db.sh

Output ./output/tui-address.webm

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

# Navigate to a review with findings
Down
Sleep 500ms

# Enter the review
Enter
Sleep 2s

# Read through the findings
Down
Sleep 300ms
Down
Sleep 300ms
Down
Sleep 300ms
Sleep 1s

# Mark as addressed with 'a'
Type "a"
Sleep 1.5s

# Confirm the action
Type "a"
Sleep 1.5s

# Go back to queue
Escape
Sleep 1s

# Show filter to hide addressed
Type "f"
Sleep 1s

# Toggle to hide addressed items
Type "h"
Sleep 1.5s

# Close filter
Escape
Sleep 1s

# Quit
Type "q"
Sleep 500ms
