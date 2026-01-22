# VHS tape for roborev status and version commands
# Run with: vhs commands-status.tape

Output ./output/commands-status.gif

# Terminal settings
Set TypingSpeed 50ms
Set Theme "Dracula"
Set FontFamily "MesloLGS NF"
Set FontSize 16
Set Width 1200
Set Height 600
Set Padding 20
Set Framerate 25


# Show version
Type "roborev version"
Enter
Sleep 2s

# Show status
Type "roborev status"
Enter
Sleep 3s

# Show help
Type "roborev --help"
Enter
Sleep 3s
