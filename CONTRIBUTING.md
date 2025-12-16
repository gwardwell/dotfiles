# Contributing to my dotfiles

## chezmoi

Files are _largely_ managed using chezmoi.

### File Naming Conventions

chezmoi uses special prefixes and suffixes in the source directory:

| Prefix/Suffix | Meaning               | Example                               |
| ------------- | --------------------- | ------------------------------------- |
| `dot_`        | Becomes `.`           | `dot_zshrc` → `~/.zshrc`              |
| `private_`    | File permissions 0600 | `private_Library/`                    |
| `empty_`      | Creates empty file    | `empty_file`                          |
| `.tmpl`       | Template file         | `dot_gitconfig.tmpl` → `~/.gitconfig` |

### Templates

Files ending in `.tmpl` are processed as [Go templates](https://pkg.go.dev/text/template). Template data is stored in `~/.config/chezmoi/chezmoi.toml`:

```toml
sourceDir = "/Users/yourusername/dotfiles"

[data]
signingkey = "ssh-ed25519 AAAA..."
gpgsign = true
```

In template files, use `{{ .variablename }}` to insert values:

```
{{- if .signingkey }}
signingkey = {{ .signingkey }}
{{- end }}
```

### Adding and Removing Files

To add a new file to chezmoi:

```
% chezmoi add PATH_TO_FILE
```

To remove a file that is tracked by chezmoi:

```
% chezmoi forget PATH_TO_FILE
```

### Applying Updates

After pulling new changes to dotfiles:

```
% chezmoi apply
```

To preview what would change first:

```
% chezmoi diff
```

### Editing Dotfiles

To edit a managed file (opens in your editor):

```
% chezmoi edit ~/.zshrc
```

Or edit directly in the source directory:

```
% cd ~/dotfiles
# make changes
% chezmoi apply
```

### Checking Status

See what chezmoi is managing:

```
% chezmoi managed
```

See what's different between source and target:

```
% chezmoi status
```

## Automated Settings Export

At any time, the export script can be run to export _all exportable changes_:

```
% ~/dotfiles/scripts/export.sh
```

Run this and any of the export scripts will update the corresponding files in this repo as well as commit and push the changes (if there are any).

### Exporting Homebrew Installations

The following command will back up Homebrew installations:

```
% ~/dotfiles/scripts/export-brewfile.sh
```

### Exporting Global npm Packages

This script will export up global npm packages:

```
% ~/dotfiles/scripts/export-npm-globals.sh
```

### Exporting iTerm Preferences

iTerm is configured to auto-save preferences to `~/dotfiles/iTerm/`. This script commits those changes:

```
% ~/dotfiles/scripts/export-iterm.sh
```

### Exporting Google Chrome Bookmarks

This script will guide you through exporting Google Chrome bookmarks as HTML (which is a manual process):

```
% ~/dotfiles/scripts/export-chrome-bookmarks.sh
```

### Syncing VS Code and Cursor Extensions

This script syncs extensions between VS Code and Cursor (bidirectional):

```
% ~/dotfiles/scripts/sync-ide-extensions.sh
```

This runs automatically as part of the main export script.

### Adding a New Export Script

To add a new automated export:

1. Create the script in `~/dotfiles/scripts/`:

```bash
touch ~/dotfiles/scripts/export-FEATURE.sh
chmod +x ~/dotfiles/scripts/export-FEATURE.sh
```

2. Use this template:

```bash
#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

echo "📦 Exporting FEATURE..."

# Your export logic here

cd "$DOTFILES_DIR"
git add PATH_TO_FILES

if ! git diff --staged --quiet; then
    git commit -m "chore: update FEATURE"
    git push
    echo "✅ Done pushing FEATURE."
else
    echo "ℹ️  No changes to FEATURE."
fi

echo ""
```

3. Add to `~/dotfiles/scripts/export.sh`:

```bash
# Run export-FEATURE.sh
if [ -f "$SCRIPT_DIR/export-FEATURE.sh" ]; then
    bash "$SCRIPT_DIR/export-FEATURE.sh"
else
    echo "⚠️  Warning: export-FEATURE.sh not found"
fi
```

4. Document the new script in this file under "Automated Settings Export"

## Manual Settings Export

### Exporting JetBrains IDE Settings

To export settings from IntelliJ IDEA or RustRover:

1. Open the IDE
2. Go to **File → Manage IDE Settings → Export Settings...**
3. Select the settings to export (or select all)
4. Save to `~/dotfiles/jetbrains/`:
   - `IntelliJ-settings.zip` for IntelliJ IDEA
   - `RustRover-settings.zip` for RustRover
5. Commit and push the changes:

```
cd ~/dotfiles
git add jetbrains/
git commit -m "chore: update JetBrains settings"
git push
```

### Updating Wallpaper

To update the dynamic wallpaper:

1. Copy your new wallpaper to `~/dotfiles/wallpaper/`
2. Commit and push:

```
cd ~/dotfiles
git add wallpaper/
git commit -m "chore: update wallpaper"
git push
```

### Updating macOS Settings

To add a new macOS setting to the automated setup:

1. Find the `defaults` command for the setting using the interactive helper:

```
% ~/dotfiles/scripts/find-macos-defaults.sh
```

This script captures a before/after snapshot of your defaults and shows you what changed.

2. Add the `defaults write` command to `~/dotfiles/scripts/macos-settings.sh`
3. Commit and push the changes:

```
cd ~/dotfiles
git add scripts/macos-settings.sh
git commit -m "chore: add macOS setting for X"
git push
```

## Cloud-provider settings

When possible, rely on the following for managing settings:

1. **Raycast** Pro with Settings Sync enabled
2. **Visual Studio Code** and **Cursor** accounts with Settings Sync enabled
3. **JetBrains IDEs** with Settings Sync enabled
4. **1Password** account for password sync
5. **Postman** account for collections sync (optional)

## Installing Apps

Apps should be installed using [Homebrew](https://brew.sh/) whenever possible. To see if an app is available through Homebrew, run:

```
% brew search <app_name>
```

You can also check to see if an app is already installed using:

```
% brew list <app_name>
```

To install an app, use:

```
% brew install --cask <app_name>
```

Don't forget to [export your Brewfile](#exporting-homebrew-installations) when you're done.
