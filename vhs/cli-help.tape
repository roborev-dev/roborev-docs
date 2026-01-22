# VHS tape for CLI help output
# Run with: vhs cli-help.tape

Output ./output/cli-help.gif

# Terminal settings
Set TypingSpeed 50ms
Set Theme "Dracula"
Set FontFamily "MesloLGS NF"
Set FontSize 16
Set Width 1200
Set Height 600
Set Padding 20
Set Framerate 25

# Show main help
Type "roborev --help"
Sleep 2s
Enter
Sleep 4s

# Show review command help
Type "roborev review --help"
Sleep 2s
Enter
Sleep 4s
