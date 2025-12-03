# Greg's Dotfiles

Download and run the install script:

```
curl -fsSL https://raw.githubusercontent.com/gwardwell/dotfiles/main/install.sh -o install.sh && bash install.sh
```

## SSH Keys for GitHub

During installation, you'll be asked how to set up SSH:

```
🔑 Setting up SSH for GitHub...

How would you like to manage SSH keys?
   1) 1Password SSH Agent (recommended)
   2) Traditional SSH key (generate new key)
   3) Skip (SSH already configured)
```

### Option 1: 1Password SSH Agent (Recommended)

Uses 1Password to manage your SSH keys with Touch ID authentication.

**During install:**

1. Select option `1` for 1Password
2. Choose whether to create a new key or use an existing one:

```
Do you have an SSH key in 1Password already?
   1) No - Create a new SSH key
   2) Yes - I have an existing key in 1Password
```

**If creating a new key**, the script guides you through:

- Enabling the SSH agent in 1Password settings
- Creating a new Ed25519 SSH key in 1Password
- Adding the public key to GitHub

**If using an existing key**, the script confirms:

- SSH agent is enabled
- Key is in a supported vault (Personal, Private, or Employee)
- Public key is already on GitHub

**Benefits:**

- Keys secured by 1Password
- Touch ID to authorize SSH requests
- Easy key management across devices
- Works with multiple GitHub accounts
- Keys never leave 1Password

### Option 2: Traditional SSH Key

Generates a new SSH key and stores it locally.

**During install:**

1. Select option `2`
2. Enter your GitHub email
3. Key is generated and copied to clipboard
4. Paste at https://github.com/settings/ssh/new

### Multiple GitHub Accounts

If managing separate personal and employer GitHub accounts:

**With 1Password:** Store multiple SSH keys in 1Password. Configure each with a different vault or tag.

**With traditional keys:** Update `~/.ssh/config`:

```
Host personal
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_personal

Host employer
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_employer
```

There are zsh aliases in `aliases-employer.zsh` to handle flipping between these hosts.

## Commit Signing (Optional)

If you chose 1Password SSH, you'll be asked about commit signing:

```
✍️  Set up commit signing?
   This adds a 'Verified' badge to your commits on GitHub.

   1) Yes - Enable commit signing
   2) No - Skip for now
```

### What Commit Signing Does

- Adds a ✅ **Verified** badge to your commits on GitHub
- Cryptographically proves commits came from you
- Uses Touch ID via 1Password (no separate GPG key needed)

### Setup Steps

1. **During install:** Paste your SSH public key when prompted
2. **Add to GitHub:** Add the same key as a **Signing Key** (not just Authentication)
   - Go to https://github.com/settings/keys
   - Click "New SSH Key"
   - Select **"Signing Key"** as the key type

### Files That Need Manual Updates

After installation, update these files for commit signing:

| File                     | Purpose                     | Action Needed               |
| ------------------------ | --------------------------- | --------------------------- |
| `~/.ssh/allowed_signers` | Verifies signatures locally | Add your email + public key |
| `~/.gitconfig`           | Already configured          | Key added during install    |

**For multiple accounts**, add each email to `~/.ssh/allowed_signers`:

```
# Personal
gwardwell@users.noreply.github.com ssh-ed25519 AAAA...your-key

# Employer (same key or different key)
your.name@employer.com ssh-ed25519 AAAA...your-key
```

### Skipping or Enabling Later

If you skipped signing during install, enable it later:

**1. Get your public key from 1Password**

**2. Edit chezmoi config:**

```bash
# Open the chezmoi config file
${EDITOR:-vim} ~/.config/chezmoi/chezmoi.toml
```

Update the `[data]` section:

```toml
[data]
signingkey = "ssh-ed25519 AAAA...your-key"
gpgsign = true
```

**3. Apply the changes:**

```bash
chezmoi apply
```

**4. Add to allowed_signers:**

```bash
echo "your@email.com ssh-ed25519 AAAA...your-key" >> ~/.ssh/allowed_signers
```

> **Note:** Since `~/.gitconfig` is managed by chezmoi, edit the chezmoi config rather than using `git config --global`.

## Manual Configuration Steps

Some applications require manual configuration after installation:

### JetBrains IDEs (IntelliJ, RustRover)

If you can't use JetBrains Settings Sync, manually import settings:

1. Open IntelliJ IDEA or RustRover
2. Go to **File → Manage IDE Settings → Import Settings...**
3. Navigate to `~/dotfiles/jetbrains/`
4. Select the appropriate settings file:
   - `IntelliJ-settings.zip` for IntelliJ IDEA
   - `RustRover-settings.zip` for RustRover
5. Click **OK** and restart the IDE

### Employer-Specific Configuration

Two files need to be copied and customized for employer-specific settings:

#### 1. Git Config (email, signing)

```bash
cp ~/dotfiles/dot_gitconfig-employer ~/.gitconfig-employer
```

Edit `~/.gitconfig-employer`:

- Set your work email address
- Optionally set a different signing key

Repos in `~/Developer/employer/` will automatically use these settings.

#### 2. Shell Aliases

```bash
cp ~/dotfiles/dot_oh-my-zsh/custom/aliases-employer.zsh ~/.oh-my-zsh/custom/
```

Edit `~/.oh-my-zsh/custom/aliases-employer.zsh`:

- Set employer GitHub org
- Configure CI/CD shortcuts
- Add employer-specific aliases

### Google Chrome

Import bookmarks:

1. Open Google Chrome
2. Go to **⋮ → Bookmarks → Bookmark Manager** (or press `⌘⇧O`)
3. Click **⋮** (top right of Bookmark Manager)
4. Select **Import bookmarks**
5. Navigate to `~/dotfiles/chrome/bookmarks.html`

### Apps Requiring Sign-in

The following apps need to be signed into after installation:

- **1Password** - Sign in to sync passwords
- **GitHub Desktop** - Sign in with GitHub account
- **Docker Desktop** - Sign in (optional, for Docker Hub)
- **Zoom** - Sign in with account
- **Claude** - Sign in with Anthropic account
- **Postman** - Sign in to sync collections (optional)
- **Raycast** - Sign in to sync settings, snippets, and extensions

### macOS System Setup

#### Apple ID & iCloud

1. Open **System Settings → Apple ID**
2. Sign in to enable iCloud services (Keychain, Find My, etc.)

#### Touch ID

1. Open **System Settings → Touch ID & Password**
2. Add fingerprints for authentication

#### FileVault (Disk Encryption)

1. Open **System Settings → Privacy & Security → FileVault**
2. Turn on FileVault for disk encryption

#### Finder Sidebar

1. Open Finder
2. Drag frequently used folders to the sidebar (e.g., `~/Developer`, `~/Sites`)

#### Login Items

To configure apps to start at login:

1. Open **System Settings → General → Login Items**
2. Add desired apps (e.g., 1Password, Raycast, Clocker)

### Hardware

#### Bluetooth Devices

Pair your Bluetooth devices (keyboard, mouse, headphones) via:

1. Open **System Settings → Bluetooth**
2. Put device in pairing mode and connect

#### Printers

1. Open **System Settings → Printers & Scanners**
2. Add your printers
