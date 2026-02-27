#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
IMAGE_NAME="roborev-screenshots"
DEMO_DATA_DIR="${TMPDIR:-/tmp}/roborev-demo-data"
OUTPUT_DIR="$SCRIPT_DIR/../public"
ROBOREV_DOCS_REPO="$SCRIPT_DIR/.."

usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Generate roborev SVG screenshots using freeze + tmux.

Options:
  --repo PATH     Path to roborev source repo (requires explicit path)
  --local         Use sibling ../roborev directory
  --skip-data     Skip demo data preparation
  --skip-build    Skip Docker image build
  -h, --help      Show this help
EOF
}

REPO="${ROBOREV_REPO:-}"
SKIP_DATA=false
SKIP_BUILD=false
USE_LOCAL=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --repo)       [[ $# -ge 2 ]] || { echo "ERROR: --repo requires a path"; exit 1; }; REPO="$2"; shift 2 ;;
        --local)      USE_LOCAL=true; shift ;;
        --skip-data)  SKIP_DATA=true; shift ;;
        --skip-build) SKIP_BUILD=true; shift ;;
        -h|--help)    usage; exit 0 ;;
        *)            echo "Unknown option: $1"; usage; exit 1 ;;
    esac
done

# Resolve repo path
if [[ "$USE_LOCAL" == "true" ]]; then
    REPO="$SCRIPT_DIR/../../roborev"
    echo "[INFO] Using local roborev: $REPO"
elif [[ -z "$REPO" ]]; then
    echo "ERROR: Must specify --local or set ROBOREV_REPO"
    echo "  --local uses sibling ../roborev directory"
    exit 1
fi

REPO_RESOLVED="$(cd "$REPO" 2>/dev/null && pwd)" || {
    echo "Error: roborev repo not found at $REPO"
    echo "Pass --repo PATH or set ROBOREV_REPO."
    exit 1
}
REPO="$REPO_RESOLVED"

echo ""
echo "=========================================="
echo "  roborev SVG Screenshot Generator"
echo "=========================================="
echo ""

# --- Step 1: Prepare demo data ---
if [[ "$SKIP_DATA" == false ]]; then
    echo "==> Preparing demo database..."
    if [[ -f "$SCRIPT_DIR/prepare-demo-db.sh" ]]; then
        "$SCRIPT_DIR/prepare-demo-db.sh"
    fi
    echo ""
fi

# --- Step 2: Build Docker image ---
if [[ "$SKIP_BUILD" == false ]]; then
    ROBOREV_VERSION=$(cd "$REPO" && git tag --sort=-v:refname | grep -E '^v[0-9]+\.' | head -1 || echo "dev")
    echo "==> Building Docker image: $IMAGE_NAME (version: $ROBOREV_VERSION)"
    DOCKER_BUILDKIT=1 docker build \
        --build-arg "VERSION=$ROBOREV_VERSION" \
        -t "$IMAGE_NAME" \
        -f "$SCRIPT_DIR/Dockerfile" "$REPO"
    echo ""
fi

# --- Step 3: Generate screenshots ---
mkdir -p "$OUTPUT_DIR"

echo "==> Generating SVG screenshots..."
docker run --rm \
    -v "$SCRIPT_DIR:/screenshots" \
    -v "$DEMO_DATA_DIR:/data" \
    -v "$OUTPUT_DIR:/output" \
    -v "$REPO:/repos/roborev:ro" \
    -v "$ROBOREV_DOCS_REPO:/repos/roborev-docs:ro" \
    -e ROBOREV_DATA_DIR=/data \
    "$IMAGE_NAME" \
    /screenshots/generate-screenshots.sh /output

echo ""
echo "Done! Output files are in $OUTPUT_DIR"
