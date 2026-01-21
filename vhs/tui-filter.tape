# VHS tape for generating TUI filter screenshot
# Run with: vhs tui-filter.tape
# Prerequisite: ./prepare-demo-db.sh

Output ../src/assets/screenshots/tui-filter.gif

# Terminal settings
Set Theme "Dracula"
Set FontFamily "MesloLGS NF"
Set FontSize 16
Set Width 1000
Set Height 800
Set Padding 20

# Use demo database (isolated roborev-only data)
Env ROBOREV_DATA_DIR "./demo-data"

# Launch roborev tui
Type "roborev tui"
Enter
Sleep 2s

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
