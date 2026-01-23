#!/bin/bash
# Generate all VHS tape recordings for roborev documentation
# Usage: ./generate-all.sh [--tape <name>] [--list] [--help]
#
# Options:
#   --tape NAME Only generate specific tape (without .tape extension)
#   --list      List all available tapes
#   --help      Show this help
#
# Runs everything inside Docker for complete isolation.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

DOCKER_IMAGE_NAME="roborev-vhs"
ROBOREV_REPO="${ROBOREV_REPO:-$SCRIPT_DIR/../../roborev}"
SINGLE_TAPE=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --tape)
            SINGLE_TAPE="$2"
            shift 2
            ;;
        --list)
            echo "Available tapes:"
            for tape in *.tape; do
                echo "  - ${tape%.tape}"
            done
            exit 0
            ;;
        --help)
            head -11 "$0" | tail -10
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Tapes that only need CLI (no daemon)
CLI_ONLY_TAPES="cli-version cli-help"

# Build daemon tapes list from all .tape files, excluding CLI-only tapes
DAEMON_TAPES=""
for tape in *.tape; do
    name="${tape%.tape}"
    if [[ ! " $CLI_ONLY_TAPES " =~ " $name " ]]; then
        DAEMON_TAPES="$DAEMON_TAPES $name"
    fi
done

echo ""
echo "=========================================="
echo "  roborev VHS Tape Generator"
echo "=========================================="
echo ""

# Check dependencies
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed"
    exit 1
fi

if [[ ! -d "$ROBOREV_REPO" ]]; then
    echo "ERROR: roborev repo not found at: $ROBOREV_REPO"
    echo "Set ROBOREV_REPO env var or clone roborev next to roborev-docs"
    exit 1
fi

# Prepare demo data
echo "[INFO] Preparing demo database..."
if [[ -f "$SCRIPT_DIR/prepare-demo-db.sh" ]]; then
    "$SCRIPT_DIR/prepare-demo-db.sh"
fi

# Build Docker image
echo "[INFO] Building Docker image..."
docker build -t "$DOCKER_IMAGE_NAME" -f "$SCRIPT_DIR/Dockerfile" "$ROBOREV_REPO"

# Create output directories
mkdir -p "$SCRIPT_DIR/output"
mkdir -p "$SCRIPT_DIR/../public"

# Function to run a tape in Docker
run_tape() {
    local tape="$1"
    local need_daemon="$2"

    if [[ -n "$SINGLE_TAPE" && "$tape" != "$SINGLE_TAPE" ]]; then
        return 0
    fi

    if [[ ! -f "${tape}.tape" ]]; then
        echo "[WARN] Tape not found: ${tape}.tape"
        return 0
    fi

    echo "[INFO] Recording $tape..."

    local daemon_cmd=""
    if [[ "$need_daemon" == "true" ]]; then
        daemon_cmd="roborev daemon run &
sleep 2
"
    fi

    docker run --rm \
        -v "$SCRIPT_DIR/demo-data:/data" \
        -v "$SCRIPT_DIR:/tapes" \
        -e ROBOREV_DATA_DIR=/data \
        "$DOCKER_IMAGE_NAME" \
        /bin/bash -c "${daemon_cmd}cd /tapes && vhs ${tape}.tape"

    echo "[SUCCESS] Generated: $tape"
}

# Run CLI-only tapes (no daemon)
echo "[INFO] Running CLI-only tapes..."
for tape in $CLI_ONLY_TAPES; do
    run_tape "$tape" "false" || true
done

# Run daemon tapes
echo "[INFO] Running daemon tapes..."
for tape in $DAEMON_TAPES; do
    run_tape "$tape" "true" || true
done

# Copy generated files to public
echo "[INFO] Copying generated files to public..."
cp "$SCRIPT_DIR/output/"*.gif "$SCRIPT_DIR/../public/" 2>/dev/null || true

# Clean up intermediate output directory
rm -rf "$SCRIPT_DIR/output"

echo ""
echo "[SUCCESS] All tapes generated!"
echo ""
echo "Output files are in: ../public/"
