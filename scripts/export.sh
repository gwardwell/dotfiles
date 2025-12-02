#!/bin/bash

# Exit on error
set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Flag to indicate running from main export script
export EXPORT_ALL=1

echo "🚀 Running all export scripts..."
echo ""

# Run export-brewfile.sh (will auto-sync without prompting)
if [ -f "$SCRIPT_DIR/export-brewfile.sh" ]; then
    bash "$SCRIPT_DIR/export-brewfile.sh"
else
    echo "⚠️  Warning: export-brewfile.sh not found"
fi

# Run export-npm-globals.sh
if [ -f "$SCRIPT_DIR/export-npm-globals.sh" ]; then
    bash "$SCRIPT_DIR/export-npm-globals.sh"
else
    echo "⚠️  Warning: export-npm-globals.sh not found"
fi

# Run export-iterm.sh
if [ -f "$SCRIPT_DIR/export-iterm.sh" ]; then
    bash "$SCRIPT_DIR/export-iterm.sh"
else
    echo "⚠️  Warning: export-iterm.sh not found"
fi

# Run export-chrome-bookmarks.sh
if [ -f "$SCRIPT_DIR/export-chrome-bookmarks.sh" ]; then
    bash "$SCRIPT_DIR/export-chrome-bookmarks.sh"
else
    echo "⚠️  Warning: export-chrome-bookmarks.sh not found"
fi

echo "🎉 All exports complete!"
