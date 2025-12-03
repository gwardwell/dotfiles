#!/bin/bash

# Interactive script to discover macOS defaults commands
# Captures before/after state to find the `defaults write` command for a setting

TEMP_DIR=$(mktemp -d)
BEFORE_FILE="$TEMP_DIR/before.txt"
AFTER_FILE="$TEMP_DIR/after.txt"

cleanup() {
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

echo "🔍 macOS Defaults Finder"
echo "========================"
echo ""
echo "This script helps you discover the \`defaults write\` command"
echo "for any macOS setting you want to automate."
echo ""

echo "📸 Capturing current defaults state..."
defaults read > "$BEFORE_FILE" 2>/dev/null
echo "✅ Snapshot saved."
echo ""

echo "🛠️  Now go to System Settings and change the setting you want to capture."
echo ""
read -p "Press Enter when you've made the change..."

echo ""
echo "📸 Capturing new defaults state..."
defaults read > "$AFTER_FILE" 2>/dev/null
echo "✅ Snapshot saved."
echo ""

echo "📊 Comparing states..."
echo ""

DIFF_OUTPUT=$(diff "$BEFORE_FILE" "$AFTER_FILE")

if [ -z "$DIFF_OUTPUT" ]; then
    echo "ℹ️  No differences found."
    echo ""
    echo "This can happen if:"
    echo "  • The setting doesn't use defaults (some use plist files directly)"
    echo "  • The setting requires a logout/restart to take effect"
    echo "  • The setting was already at the value you selected"
    echo ""
else
    echo "🎯 Changes detected:"
    echo "────────────────────"
    echo "$DIFF_OUTPUT"
    echo "────────────────────"
    echo ""
    echo "💡 Look for lines starting with '>' (added) or '<' (removed)"
    echo "   to identify the domain and key that changed."
    echo ""
    echo "📝 To add this to your setup, add a \`defaults write\` command"
    echo "   to ~/dotfiles/scripts/macos-settings.sh"
    echo ""
fi

