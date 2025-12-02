#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

echo "📚 Exporting Chrome bookmarks..."
echo ""
echo "📝 To export bookmarks:"
echo "   1. Chrome Bookmark Manager will open"
echo "   2. Click ⋮ (top right of Bookmark Manager)"
echo "   3. Select 'Export bookmarks'"
echo "   4. Save to: ~/dotfiles/chrome/bookmarks.html"
echo ""

# Open Chrome Bookmark Manager
open "chrome://bookmarks"

read -p "Press Enter after you've exported bookmarks..."

cd "$DOTFILES_DIR"
git add chrome/bookmarks.html

if ! git diff --staged --quiet; then
    git commit -m "chore: update Chrome bookmarks"
    git push
    echo "✅ Done pushing Chrome bookmarks."
else
    echo "ℹ️  No changes to Chrome bookmarks."
fi

echo ""
