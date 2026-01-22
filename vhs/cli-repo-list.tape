# VHS tape for CLI repo list output
# Run with: vhs cli-repo-list.tape

Output ./output/cli-repo-list.gif

# Terminal settings
Set TypingSpeed 50ms
Set Theme "Dracula"
Set FontFamily "MesloLGS NF"
Set FontSize 16
Set Width 1200
Set Height 600
Set Padding 20
Set Framerate 25


# Show repo list
Type "roborev repo list"
Enter
Sleep 3s

# Show repo details for first repo
Type "roborev repo show roborev"
Enter
Sleep 4s
