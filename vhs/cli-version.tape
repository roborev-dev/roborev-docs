# VHS tape for CLI version output
# Run with: vhs cli-version.tape

Output ./output/cli-version.webm

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
Sleep 3s
