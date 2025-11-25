#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/helsingborg-stad/php-runner.git"
DEFAULT_DIR="$HOME/.php-docker-php-run"
TARGET="$HOME/.local/bin"

# detect script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Checking installation source..."

if [ -d "$SCRIPT_DIR/.git" ]; then
	# running from inside the repo already
	echo "Running inside a git repo → installing from local folder:"
	echo "  $SCRIPT_DIR"
	INSTALL_DIR="$SCRIPT_DIR"
else
	# running from curl or raw script
	echo "Not inside a git repo → cloning fresh copy..."
	rm -rf "$DEFAULT_DIR"
	git clone "$REPO_URL" "$DEFAULT_DIR"
	INSTALL_DIR="$DEFAULT_DIR"
fi

echo "Building Docker image..."
docker build -t php-runner "$INSTALL_DIR"

echo "Installing php-run..."
mkdir -p "$TARGET"
cp "$INSTALL_DIR/scripts/php-run" "$TARGET/php-run"
chmod +x "$TARGET/php-run"

echo ""
echo "Installation complete!"
echo "Make sure $TARGET is in your PATH."
echo ""
echo "Test with:"
echo "  php-run -v"
