#!/bin/bash

# Exit on error
set -e

DOTFILES_DIR="$HOME/dotfiles"
NPM_GLOBALS_FILE="npm-globals.txt"

echo "📦 Dumping global npm packages..."

# Get parseable list and extract just package names
npm list -g --depth=0 --parseable | while read -r line; do
    # Skip empty lines and the base lib path
    [[ -z "$line" || "$line" =~ ^/.*lib$ ]] && continue

    # Extract package name from path
    if [[ "$line" =~ /node_modules/(.+)$ ]]; then
        echo "${BASH_REMATCH[1]}"
    fi
done > "$DOTFILES_DIR/$NPM_GLOBALS_FILE"

echo "✅ Done dumping global npm packages."
echo ""

echo "📦 Adding $NPM_GLOBALS_FILE to Git..."
cd "$DOTFILES_DIR"
git add "$NPM_GLOBALS_FILE"

# Check if there are changes to commit
if git diff --staged --quiet; then
    echo "ℹ️  No changes to $NPM_GLOBALS_FILE - skipping commit."
else
    git commit -m "chore: update $NPM_GLOBALS_FILE"
    git push
    echo "✅ Done pushing $NPM_GLOBALS_FILE to GitHub."
fi
echo ""

echo "🎉 Done!"
echo ""
