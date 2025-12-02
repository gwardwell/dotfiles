#!/bin/bash

# Exit on error
set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "🚀 Setting up dotfiles for $(whoami)..."
echo ""

# Clone dotfiles if not present
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "📦 Cloning dotfiles..."
    git clone https://github.com/gwardwell/dotfiles.git "$DOTFILES_DIR"
    echo "✅ Done cloning dotfiles."
    echo ""
fi

# Install Homebrew if needed
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for this session
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    echo "✅ Done installing Homebrew."
    echo ""
else
    echo "✅ Homebrew already installed."
    echo ""
fi

# Install Homebrew packages
echo "📦 Installing packages from Brewfile..."
cd "$DOTFILES_DIR"
brew bundle --file="$DOTFILES_DIR/Brewfile"
echo "✅ Done installing packages."
echo ""

# Set up Git LFS
if command -v git-lfs &> /dev/null; then
    echo "🔧 Setting up Git LFS..."
    git lfs install

    # Fetch any LFS files that were pointers during initial clone
    cd "$DOTFILES_DIR"
    git lfs pull
    echo "✅ Git LFS configured."
    echo ""
fi

# Install Cursor extensions from Brewfile's vscode list
if command -v cursor &> /dev/null && [ -f "$DOTFILES_DIR/Brewfile" ]; then
    echo "📦 Installing Cursor extensions..."
    grep '^vscode "' "$DOTFILES_DIR/Brewfile" | sed 's/vscode "\(.*\)"/\1/' | while read -r ext; do
        echo "  Installing $ext..."
        cursor --install-extension "$ext" 2>/dev/null || echo "  ⚠️  Failed to install $ext"
    done
    echo "✅ Done installing Cursor extensions."
    echo ""
fi

# Set up chezmoi with custom source directory
CHEZMOI_SOURCE="$DOTFILES_DIR"

# Configure chezmoi to use custom source directory
mkdir -p "$HOME/.config/chezmoi"
if [ ! -f "$HOME/.config/chezmoi/chezmoi.toml" ]; then
    echo "⚙️  Configuring chezmoi..."
    cat > "$HOME/.config/chezmoi/chezmoi.toml" << EOF
sourceDir = "$CHEZMOI_SOURCE"
EOF
    echo "✅ Done configuring chezmoi."
    echo ""
fi

# Initialize/apply chezmoi
if chezmoi managed 2>/dev/null | grep -q .; then
    echo "🔄 Applying chezmoi configuration..."
    chezmoi apply -v
    echo "✅ Done applying chezmoi configuration."
else
    echo "🎯 Initializing chezmoi..."
    chezmoi init --source="$CHEZMOI_SOURCE" --apply
    echo "✅ Done initializing chezmoi."
fi
echo ""

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "💻 Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "✅ Done installing Oh My Zsh."
    echo ""
else
    echo "✅ Oh My Zsh already installed."
    echo ""
fi

# Install Oh My Zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "📦 Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    echo "✅ Done installing zsh-autosuggestions."
    echo ""
else
    echo "✅ zsh-autosuggestions already installed."
    echo ""
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "📦 Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    echo "✅ Done installing zsh-syntax-highlighting."
    echo ""
else
    echo "✅ zsh-syntax-highlighting already installed."
    echo ""
fi

# Set ZSH as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🐚 Setting ZSH as default shell..."
    chsh -s "$(which zsh)"
    echo "✅ Done. You'll need to log out and back in for this to take effect."
    echo ""
fi

# Apply macOS settings if script exists
if [ -f "$DOTFILES_DIR/scripts/macos-settings.sh" ]; then
    echo "⚙️  Applying macOS settings..."
    bash "$DOTFILES_DIR/scripts/macos-settings.sh"
    echo "✅ Done applying macOS settings."
    echo ""
fi

# Configure iTerm to use dotfiles for preferences
if [ -d "/Applications/iTerm.app" ] || command -v iTerm &> /dev/null; then
    echo "⚙️  Configuring iTerm preferences..."

    # Set custom preferences folder
    defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES_DIR/iTerm"

    # Enable loading preferences from custom folder
    defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

    # Enable saving changes to custom folder
    defaults write com.googlecode.iterm2 SaveChangesToCustomFolder -bool true

    # Auto-save changes to custom folder without prompting
    defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2

    echo "✅ iTerm configured to load/save preferences from ~/dotfiles/iTerm/"
    echo ""
fi

# Set up dynamic wallpaper
WALLPAPER="$DOTFILES_DIR/wallpaper/outset_dynamic_wallpaper.heic"
if [ -f "$WALLPAPER" ]; then
    echo "🖼️  Setting up dynamic wallpaper..."
    echo ""
    echo "📝 To apply the dynamic wallpaper:"
    echo "   1. System Settings → Wallpaper will open"
    echo "   2. Click 'Add Folder' or 'Add Photo'"
    echo "   3. Navigate to: ~/dotfiles/wallpaper/"
    echo "   4. Select the dynamic wallpaper file"
    echo ""

    # Open System Settings to Wallpaper pane (macOS 13+)
    # Falls back to opening System Settings if the URL scheme changes
    open "x-apple.systempreferences:com.apple.Wallpaper-Settings.extension" 2>/dev/null || \
        open -a "System Settings" 2>/dev/null || \
        open -a "System Preferences"

    read -p "Press Enter after you've set the wallpaper..."
    echo "✅ Wallpaper setup complete."
    echo ""
fi

# Set up SSH key for GitHub
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    echo "🔑 Setting up SSH key for GitHub..."
    echo ""
    echo "Enter your GitHub email address:"
    read -r github_email

    # Generate SSH key
    ssh-keygen -t ed25519 -C "$github_email" -f "$HOME/.ssh/id_ed25519" -N ""

    # Start ssh-agent and add key
    eval "$(ssh-agent -s)"

    # Add to macOS keychain
    ssh-add --apple-use-keychain "$HOME/.ssh/id_ed25519"

    # Create/update SSH config for macOS keychain
    mkdir -p "$HOME/.ssh"
    if ! grep -q "UseKeychain yes" "$HOME/.ssh/config" 2>/dev/null; then
        cat >> "$HOME/.ssh/config" << EOF

Host github.com
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_ed25519
EOF
    fi

    # Copy public key to clipboard
    pbcopy < "$HOME/.ssh/id_ed25519.pub"

    echo "✅ SSH key generated and copied to clipboard!"
    echo ""
    echo "📝 Next: Add your SSH key to GitHub:"
    echo "   1. Go to https://github.com/settings/ssh/new"
    echo "   2. Paste the key from your clipboard"
    echo "   3. Give it a name (e.g., 'MacBook Pro')"
    echo ""
    read -p "Press Enter after you've added the key to GitHub..."
else
    echo "✅ SSH key already exists."
    echo ""
fi

# Install global npm packages if file exists
if [ -f "$DOTFILES_DIR/npm-globals.txt" ]; then
    echo "📦 Installing global npm packages..."
    while read -r package; do
        # Skip empty lines and comments
        [[ -z "$package" || "$package" =~ ^# ]] && continue

        echo "  Installing $package..."
        npm install -g "$package" 2>/dev/null || echo "  ⚠️  Failed to install $package"
    done < "$DOTFILES_DIR/npm-globals.txt"
    echo "✅ Done installing npm packages."
    echo ""
fi

# Set up n for Node version management
if command -v n &> /dev/null; then
    echo "🔧 Setting up n for Node version management..."

    # Set n's installation prefix
    export N_PREFIX="$HOME/.n"

    # Install latest LTS via n (this makes n take over from Homebrew node)
    n lts

    echo "✅ Done setting up n. n is now managing Node versions."
    echo ""
fi

# Create common directories
mkdir -p "$HOME/Developer/personal"
mkdir -p "$HOME/Sites"

echo ""
echo "🎉 Setup complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Some macOS settings require a logout/restart to take effect"
echo "  3. Check Chrome Apps documentation to recreate web app shortcuts"
echo ""
