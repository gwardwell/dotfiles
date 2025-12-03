#!/bin/bash

# Exit on error
set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "🚀 Setting up dotfiles for $(whoami)..."
echo ""

# Check for git and install Xcode CLT if needed
if ! command -v git &> /dev/null; then
    echo "📦 Git not found. Installing Xcode Command Line Tools..."
    xcode-select --install
    echo ""
    echo "⏳ Please complete the installation in the popup window."
    echo "   This may take a few minutes."
    echo ""
    read -p "Press Enter after Xcode Command Line Tools is installed..."
    echo ""
fi

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

# Set up SSH for GitHub (after brew so 1Password is available)
echo "🔑 Setting up SSH for GitHub..."
echo ""
echo "How would you like to manage SSH keys?"
echo "   1) 1Password SSH Agent (recommended)"
echo "   2) Traditional SSH key (generate new key)"
echo "   3) Skip (SSH already configured)"
echo ""
read -p "Enter choice [1/2/3]: " ssh_choice

case $ssh_choice in
    1)
        # 1Password SSH Agent setup
        echo ""
        echo "📝 Setting up 1Password SSH Agent..."

        # Prompt to open 1Password if not running
        if ! pgrep -x "1Password" > /dev/null; then
            echo "📝 Opening 1Password - please sign in if needed..."
            open -a "1Password" 2>/dev/null || true
            read -p "Press Enter after 1Password is open and signed in..."
            echo ""
        fi

        mkdir -p "$HOME/.ssh"
        chmod 700 "$HOME/.ssh"

        # Create SSH config for 1Password
        if ! grep -q "1Password" "$HOME/.ssh/config" 2>/dev/null; then
            cat >> "$HOME/.ssh/config" << 'EOF'

# 1Password SSH Agent
Host *
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
EOF
            chmod 600 "$HOME/.ssh/config"
        fi

        echo ""
        echo "✅ SSH config updated for 1Password!"
        echo ""
        echo "Do you have an SSH key in 1Password already?"
        echo "   1) No - Create a new SSH key"
        echo "   2) Yes - I have an existing key in 1Password"
        echo ""
        read -p "Enter choice [1/2]: " op_key_choice

        case $op_key_choice in
            1)
                # Create new key
                echo ""
                echo "📝 Let's create a new SSH key in 1Password:"
                echo ""
                echo "   Step 1: Enable the SSH Agent"
                echo "   ─────────────────────────────"
                echo "   1. Open 1Password → Settings (⌘,)"
                echo "   2. Go to 'Developer' section"
                echo "   3. Enable 'Use the SSH agent'"
                echo "   4. (Optional) Enable 'Authorize using Touch ID'"
                echo ""
                read -p "Press Enter when the SSH agent is enabled..."

                echo ""
                echo "   Step 2: Create SSH Key"
                echo "   ──────────────────────"
                echo "   1. In 1Password, click '+ New Item'"
                echo "   2. Select 'SSH Key'"
                echo "   3. Click 'Add Private Key' → 'Generate a New Key'"
                echo "   4. Choose 'Ed25519' (recommended)"
                echo "   5. Give it a title (e.g., 'GitHub - Personal')"
                echo "   6. Click 'Save'"
                echo ""
                read -p "Press Enter when your key is created..."

                echo ""
                echo "   Step 3: Add Public Key to GitHub"
                echo "   ─────────────────────────────────"
                echo "   1. In 1Password, open your new SSH Key item"
                echo "   2. Click 'public key' to copy it"
                echo "   3. Go to: https://github.com/settings/ssh/new"
                echo "   4. Paste the public key"
                echo "   5. Give it a name and click 'Add SSH key'"
                echo ""

                # Open GitHub SSH settings
                open "https://github.com/settings/ssh/new" 2>/dev/null || true

                read -p "Press Enter when you've added the key to GitHub..."
                echo ""
                echo "✅ 1Password SSH setup complete!"
                ;;
            2)
                # Existing key
                echo ""
                echo "📝 Using existing SSH key from 1Password:"
                echo ""
                echo "   Step 1: Enable the SSH Agent (if not already)"
                echo "   ─────────────────────────────────────────────"
                echo "   1. Open 1Password → Settings (⌘,)"
                echo "   2. Go to 'Developer' section"
                echo "   3. Enable 'Use the SSH agent'"
                echo "   4. (Optional) Enable 'Authorize using Touch ID'"
                echo ""
                echo "   Step 2: Verify your key is available"
                echo "   ─────────────────────────────────────"
                echo "   Your SSH key should be stored in your Personal,"
                echo "   Private, or Employee vault to be available."
                echo ""
                echo "   Step 3: Ensure public key is on GitHub"
                echo "   ──────────────────────────────────────"
                echo "   If not already added, copy your public key from"
                echo "   1Password and add it at: https://github.com/settings/keys"
                echo ""
                read -p "Press Enter when ready..."
                echo ""
                echo "✅ 1Password SSH setup complete!"
                ;;
            *)
                echo "⚠️  Invalid choice. Please configure 1Password manually."
                ;;
        esac

        echo ""
        ;;
    2)
        # Traditional SSH key setup
        if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
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
            chmod 700 "$HOME/.ssh"
            if ! grep -q "UseKeychain yes" "$HOME/.ssh/config" 2>/dev/null; then
                cat >> "$HOME/.ssh/config" << EOF

Host github.com
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_ed25519
EOF
                chmod 600 "$HOME/.ssh/config"
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
            echo "✅ SSH key already exists at ~/.ssh/id_ed25519"
            echo ""
        fi
        ;;
    3)
        echo "⏭️  Skipping SSH setup."
        echo ""
        ;;
    *)
        echo "⚠️  Invalid choice. Skipping SSH setup."
        echo ""
        ;;
esac

# Update dotfiles remote to use SSH (if SSH was configured)
if [[ "$ssh_choice" == "1" || "$ssh_choice" == "2" ]]; then
    echo "🔗 Updating dotfiles remote to use SSH..."
    cd "$DOTFILES_DIR"
    git remote set-url origin git@github.com:gwardwell/dotfiles.git
    echo "✅ Remote updated. You can now push changes via SSH."
    echo ""
fi

# Set up commit signing (optional, requires SSH key)
if [[ "$ssh_choice" == "1" ]]; then
    echo "✍️  Set up commit signing?"
    echo "   This adds a 'Verified' badge to your commits on GitHub."
    echo ""
    echo "   1) Yes - Enable commit signing"
    echo "   2) No - Skip for now"
    echo ""
    read -p "Enter choice [1/2]: " signing_choice

    if [[ "$signing_choice" == "1" ]]; then
        echo ""
        echo "📝 Setting up commit signing with 1Password..."
        echo ""
        echo "   Step 1: Get your SSH public key"
        echo "   ─────────────────────────────────"
        echo "   1. Open 1Password"
        echo "   2. Find your SSH Key item"
        echo "   3. Copy the 'public key' field"
        echo ""
        read -p "Paste your SSH public key: " signing_key

        if [[ -n "$signing_key" ]]; then
            # Get email from gitconfig
            git_email=$(git config --global user.email)

            # Update allowed_signers file
            echo "$git_email $signing_key" >> "$HOME/.ssh/allowed_signers"

            # Enable signing in gitconfig
            git config --global user.signingkey "$signing_key"
            git config --global commit.gpgsign true

            echo ""
            echo "✅ Commit signing enabled for $git_email"
            echo ""
            echo "   Step 2: Add signing key to GitHub"
            echo "   ──────────────────────────────────"
            echo "   1. Go to: https://github.com/settings/keys"
            echo "   2. Click 'New SSH Key'"
            echo "   3. Select 'Signing Key' as the key type"
            echo "   4. Paste your public key"
            echo ""

            open "https://github.com/settings/ssh/new" 2>/dev/null || true

            read -p "Press Enter after you've added the signing key to GitHub..."
            echo ""
            echo "✅ Commit signing setup complete!"
            echo ""
            echo "   ┌─────────────────────────────────────────────────────┐"
            echo "   │  📋 MANUAL STEPS FOR MULTIPLE ACCOUNTS              │"
            echo "   ├─────────────────────────────────────────────────────┤"
            echo "   │  If you use a work email for employer repos:        │"
            echo "   │                                                     │"
            echo "   │  1. Edit ~/.ssh/allowed_signers                     │"
            echo "   │     Add: work@employer.com ssh-ed25519 AAAA...      │"
            echo "   │                                                     │"
            echo "   │  2. Edit ~/.gitconfig-employer                      │"
            echo "   │     Set your work email and signing key             │"
            echo "   │                                                     │"
            echo "   │  See README.md for details.                         │"
            echo "   └─────────────────────────────────────────────────────┘"
            echo ""
        else
            echo "⚠️  No key provided. Skipping signing setup."
        fi
        echo ""
    else
        echo "⏭️  Skipping commit signing."
        echo "   You can enable it later - see README.md for instructions."
        echo ""
    fi
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

# Install Oh My Zsh if not present (before chezmoi so .zshrc can reference it)
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

# Initialize/apply chezmoi (after Oh My Zsh so .zshrc references work)
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

# Set up n for Node version management
echo "🔧 Setting up n for Node version management..."

# Set n's installation prefix
export N_PREFIX="$HOME/.n"
mkdir -p "$N_PREFIX"

# Install n if not already available
if ! command -v n &> /dev/null; then
    echo "  Installing n..."
    npm install -g n 2>/dev/null || echo "  ⚠️  Failed to install n"
fi

# Install latest LTS via n (this makes n take over from Homebrew node)
if command -v n &> /dev/null; then
    n lts

    # Update PATH for this session to use n's node
    export PATH="$N_PREFIX/bin:$PATH"

    echo "✅ Done setting up n. n is now managing Node versions."
    echo ""
else
    echo "⚠️  n not available. Skipping Node version management setup."
    echo ""
fi

# Install global npm packages if file exists
if [ -f "$DOTFILES_DIR/npm-globals.txt" ]; then
    echo "📦 Installing global npm packages..."
    while read -r package; do
        # Skip empty lines and comments
        [[ -z "$package" || "$package" =~ ^# ]] && continue

        # Skip n (already installed above)
        [[ "$package" == "n" ]] && continue

        # Skip npm (comes with node)
        [[ "$package" == "npm" ]] && continue

        echo "  Installing $package..."
        npm install -g "$package" 2>/dev/null || echo "  ⚠️  Failed to install $package"
    done < "$DOTFILES_DIR/npm-globals.txt"
    echo "✅ Done installing npm packages."
    echo ""
fi

# Create common directories
mkdir -p "$HOME/Developer/personal"
mkdir -p "$HOME/Developer/employer"
mkdir -p "$HOME/Sites"

echo ""
echo "🎉 Setup complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Some macOS settings require a logout/restart to take effect"
echo ""
echo "📋 Manual configuration (if using multiple GitHub accounts):"
echo "  • Copy and edit employer config:"
echo "      cp ~/dotfiles/dot_gitconfig-employer ~/.gitconfig-employer"
echo "      cp ~/dotfiles/dot_oh-my-zsh/custom/aliases-employer.zsh ~/.oh-my-zsh/custom/"
echo ""
echo "  • If using commit signing, add employer email to:"
echo "      ~/.ssh/allowed_signers"
echo ""
echo "  See README.md for full details."
echo ""
