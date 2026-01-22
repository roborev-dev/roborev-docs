# VHS tape for branch review workflow
# Run with: vhs branch-review.tape
# Prerequisite: Git repo with a feature branch containing changes
#
# Setup required:
#   cd /tmp && git clone <test-repo> branch-test && cd branch-test
#   git checkout -b feature/add-auth
#   # Make some changes to review
#   git add . && git commit -m "Add auth feature"

Output ./output/branch-review.gif

# Terminal settings
Set TypingSpeed 50ms
Set Theme "Dracula"
Set FontFamily "MesloLGS NF"
Set FontSize 16
Set Width 1200
Set Height 600
Set Padding 20
Set Framerate 25

# Connect to daemon running in Docker
Env ROBOREV_DATA_DIR "./demo-data"

# Show current branch
Type "git branch"
Enter
Sleep 2s

# Show what will be reviewed (diff from main)
Type "git log main..HEAD --oneline"
Enter
Sleep 2s

# Review the branch against main
Type "roborev review --base main"
Enter
Sleep 5s

# Check review status
Type "roborev status"
Enter
Sleep 3s

# Open TUI to see the review
Type "roborev tui"
Enter
Sleep 3s

# Navigate to see findings
Type "j"
Sleep 500ms
Enter
Sleep 4s

# Quit
Type "q"
Sleep 500ms
