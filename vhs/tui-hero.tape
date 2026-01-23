# VHS tape for hero image on homepage
# Run with: vhs tui-hero.tape
# Prerequisite: ./prepare-demo-db.sh

Output ./output/tui-hero.webm

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
Down
Down
Sleep 2s
Enter
Sleep 2s

# Final frame is captured as the output
