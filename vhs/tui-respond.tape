# VHS tape for TUI respond modal workflow
# Run with: vhs tui-respond.tape
# Shows the respond modal for adding comments to reviews

Output ./output/tui-respond.webm

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

# Navigate to a review
Type "j"
Sleep 500ms
Enter
Sleep 2s

# Open respond modal with 'c'
Type "c"
Sleep 1s

# Type a multi-line response (Ctrl+j for newlines)
Type "Thanks for the review! The null check on line 42"
Sleep 500ms
Ctrl+j
Sleep 300ms
Type "is intentional - we handle nulls in the caller."
Sleep 2s

# Submit the response with Enter
Enter
Sleep 2s

# Quit
Type "q"
Sleep 500ms
