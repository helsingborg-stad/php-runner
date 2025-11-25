#!/usr/bin/env bash
set -e

REPO_URL="hhttps://github.com/helsingborg-stad/php-runner.git"
INSTALL_DIR="$HOME/.php-docker-php-run"
TARGET="$HOME/.local/bin"

echo "Cloning repo..."
rm -rf "$INSTALL_DIR"
git clone "$REPO_URL" "$INSTALL_DIR"

echo "Building Docker image..."
docker build -t php-runner "$INSTALL_DIR"

echo "Installing php-run..."
mkdir -p "$TARGET"
cp "$INSTALL_DIR/scripts/php-run" "$TARGET/php-run"
chmod +x "$TARGET/php-run"

echo ""
echo "Installation complete!"
echo "Make sure $TARGET is in your PATH."
echo "Test with: php-run -v"
