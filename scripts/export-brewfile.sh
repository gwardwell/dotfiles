#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
BREWFILE="Brewfile"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Flag to tell sync script not to ask about brewfile
export CALLED_FROM_BREWFILE=1

# Sync IDE extensions (skip if already synced)
if [ -f "$SCRIPT_DIR/sync-ide-extensions.sh" ]; then
    if [ "$ALREADY_SYNCED" = "1" ]; then
        # Already synced from sync-ide-extensions.sh - skip
        echo "⏭️  IDE extensions already synced."
        echo ""
    elif [ "$EXPORT_ALL" = "1" ]; then
        # Running from export.sh - sync without prompting
        bash "$SCRIPT_DIR/sync-ide-extensions.sh"
    else
        # Running standalone - ask first
        echo "🔄 Sync VS Code and Cursor extensions before exporting?"
        read -p "   (This ensures Brewfile captures all extensions) [y/N]: " sync_choice

        if [[ "$sync_choice" =~ ^[Yy]$ ]]; then
            bash "$SCRIPT_DIR/sync-ide-extensions.sh"
        else
            echo "⏭️  Skipping extension sync."
            echo ""
        fi
    fi
fi

echo "📦 Exporting $BREWFILE..."
brew bundle dump --describe --force --file="$DOTFILES_DIR/$BREWFILE"
echo "✅ Done exporting $BREWFILE."
echo ""

echo "📦 Adding $BREWFILE to Git..."
cd "$DOTFILES_DIR"
git add "$BREWFILE"

if git diff --staged --quiet; then
    echo "ℹ️  No changes to $BREWFILE - skipping commit."
else
    git commit -m "chore: update $BREWFILE"
    git push
    echo "✅ Done pushing $BREWFILE to GitHub."
fi
