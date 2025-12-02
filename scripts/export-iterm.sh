#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

echo "💻 Committing iTerm preferences..."

# iTerm auto-saves to ~/dotfiles/iTerm/ when configured
# This script just commits those changes

cd "$DOTFILES_DIR"
git add iTerm/

if ! git diff --staged --quiet; then
    git commit -m "chore: update iTerm preferences"
    git push
    echo "✅ Done pushing iTerm preferences."
else
    echo "ℹ️  No changes to iTerm preferences."
fi

echo ""

