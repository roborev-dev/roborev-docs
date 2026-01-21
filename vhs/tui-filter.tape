# VHS tape for generating TUI filter screenshot
# Run with: vhs tui-filter.tape
# Prerequisite: ./prepare-demo-db.sh

Output ../public/tui-filter.gif

# Terminal settings
Set TypingSpeed 200ms
Set Theme "Dracula"
Set FontFamily "MesloLGS NF"
Set FontSize 32
Set Width 2000
Set Height 1600
Set Padding 20
Set Framerate 25

# Use demo database (isolated roborev-only data)
Env ROBOREV_DATA_DIR "./demo-data"

# Launch roborev tui
Type "roborev tui"
Enter
Sleep 2s
Down
Down
Sleep 1s
Enter
Sleep 2s
Type "a"
Sleep 2s
Type "a"
Sleep 2s

Escape
Down
Down
Enter
Sleep 2s

# Final frame is captured as the output
