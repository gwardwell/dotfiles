# Greg's Dotfiles

Download and run the install script:

```
curl -fsSL https://raw.githubusercontent.com/gwardwell/dotfiles/main/install.sh -o install.sh && bash install.sh
```

## SSH Keys for GitHub

The install script will set up a new SSH key for use with GitHub.

During installation it will ask for a GitHub email address:

```
🔑 Setting up SSH key for GitHub...

Enter your GitHub email address:
```

Once an email address is entered, it will:

- Generate an SSH key
- Add the key to Apple Keychain
- Set up `.ssh/config`
- Copy the public key to clipboard

It will then display the following instructions:

```
✅ SSH key generated and copied to clipboard!"

📝 Next: Add your SSH key to GitHub:
   1. Go to https://github.com/settings/ssh/new
   2. Paste the key from your clipboard
   3. Give it a name (e.g., 'MacBook Pro')

Press Enter after you've added the key to GitHub...
```

Once that is complete and `Enter` is pressed, the install script will continue.

### Multiple GitHub Accounts

If managing a GitHub situation with separate personal/OSS and private company GitHub accounts, the standard SSH config won't work.

In that case, update `~/.ssh/config` to handle custom hosts:

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

There are already zsh aliases to handle flipping between these hosts.

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
