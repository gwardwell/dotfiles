#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 Syncing VS Code and Cursor extensions..."
echo ""

# Get extensions from both IDEs
VSCODE_EXTS=$(code --list-extensions 2>/dev/null | sort)
CURSOR_EXTS=$(cursor --list-extensions 2>/dev/null | sort)

if [ -z "$VSCODE_EXTS" ] && [ -z "$CURSOR_EXTS" ]; then
    echo "⚠️  Neither VS Code nor Cursor found."
    exit 1
fi

# Find extensions only in VS Code
ONLY_VSCODE=$(comm -23 <(echo "$VSCODE_EXTS") <(echo "$CURSOR_EXTS") 2>/dev/null)

# Find extensions only in Cursor
ONLY_CURSOR=$(comm -13 <(echo "$VSCODE_EXTS") <(echo "$CURSOR_EXTS") 2>/dev/null)

# Install missing extensions to Cursor
if [ -n "$ONLY_VSCODE" ]; then
    echo "📦 Installing to Cursor (from VS Code):"
    echo "$ONLY_VSCODE" | while read -r ext; do
        [ -z "$ext" ] && continue
        echo "  Installing $ext..."
        cursor --install-extension "$ext" 2>/dev/null || echo "  ⚠️  Failed: $ext"
    done
    echo ""
fi

# Install missing extensions to VS Code
if [ -n "$ONLY_CURSOR" ]; then
    echo "📦 Installing to VS Code (from Cursor):"
    echo "$ONLY_CURSOR" | while read -r ext; do
        [ -z "$ext" ] && continue
        echo "  Installing $ext..."
        code --install-extension "$ext" 2>/dev/null || echo "  ⚠️  Failed: $ext"
    done
    echo ""
fi

if [ -z "$ONLY_VSCODE" ] && [ -z "$ONLY_CURSOR" ]; then
    echo "✅ VS Code and Cursor extensions are already in sync!"
else
    echo "✅ Extensions synced!"
fi

echo ""

# If NOT called from brewfile export, ask about exporting Brewfile
if [ "$CALLED_FROM_BREWFILE" != "1" ]; then
    echo "📦 Export Brewfile to capture synced extensions?"
    read -p "   [y/N]: " export_choice

    if [[ "$export_choice" =~ ^[Yy]$ ]]; then
        # Tell brewfile export we already synced
        export ALREADY_SYNCED=1
        bash "$SCRIPT_DIR/export-brewfile.sh"
    fi
fi
