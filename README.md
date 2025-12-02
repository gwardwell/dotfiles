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

### Employer-Specific Aliases

Copy and customize the employer aliases template:

1. Copy the template:
   ```bash
   cp ~/dotfiles/dot_oh-my-zsh/custom/aliases-employer.zsh ~/.oh-my-zsh/custom/
   ```
2. Edit `~/.oh-my-zsh/custom/aliases-employer.zsh` with your employer-specific aliases

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
