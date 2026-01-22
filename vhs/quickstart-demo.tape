# VHS tape for quickstart demo
# Run with: vhs quickstart-demo.tape
# Prerequisite: Fresh git repo with some code to review
#
# Setup required:
#   cd /tmp && mkdir quickstart-test && cd quickstart-test
#   git init
#   echo 'console.log("hello")' > app.js
#   git add . && git commit -m "Initial commit"
#   echo 'function foo() { return bar }' >> app.js  # Bad code to review

Output ./output/quickstart-demo.gif

# Terminal settings
Set TypingSpeed 50ms
Set Theme "Dracula"
Set FontFamily "MesloLGS NF"
Set FontSize 16
Set Width 1200
Set Height 600
Set Padding 20
Set Framerate 25

# Clean environment for demo
Env ROBOREV_DATA_DIR "/tmp/roborev-quickstart-demo"

# Show we're in a git repo
Type "pwd && ls -la"
Enter
Sleep 2s

# Initialize roborev
Type "roborev init"
Enter
Sleep 3s

# Show the config created
Type "cat .roborev.toml"
Enter
Sleep 3s

# Run first review on uncommitted changes
Type "roborev review"
Enter
Sleep 5s

# Launch TUI to see the review
Type "roborev tui"
Enter
Sleep 3s

# Navigate to see the review
Type "j"
Sleep 500ms
Enter
Sleep 4s

# Quit TUI
Type "q"
Sleep 500ms
