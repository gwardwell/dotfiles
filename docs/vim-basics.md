# Vim Basics

A quick reference for basic Vim usage. Your dotfiles include a `.vimrc` with sensible defaults, so Vim should feel reasonably modern.

## Modes

Vim has different modes for different actions:

| Mode | How to Enter | Purpose |
|------|--------------|---------|
| **Normal** | `Esc` or `jk` | Navigate, delete, copy, paste |
| **Insert** | `i`, `a`, `o` | Type text |
| **Visual** | `v` | Select text |
| **Command** | `:` | Run commands (save, quit, search/replace) |

## Essential Commands

### Getting In and Out

| Command | Action |
|---------|--------|
| `i` | Enter insert mode at cursor |
| `a` | Enter insert mode after cursor |
| `o` | Insert new line below and enter insert mode |
| `O` | Insert new line above and enter insert mode |
| `Esc` | Return to normal mode |
| `jk` | Return to normal mode (custom shortcut) |

### Saving and Quitting

| Command | Action |
|---------|--------|
| `:w` | Save (write) |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving (discard changes) |
| `ZZ` | Save and quit (shortcut) |

### Navigation

| Command | Action |
|---------|--------|
| `h` `j` `k` `l` | Left, down, up, right |
| `w` | Jump to next word |
| `b` | Jump to previous word |
| `0` | Jump to beginning of line |
| `$` | Jump to end of line |
| `gg` | Jump to beginning of file |
| `G` | Jump to end of file |
| `5G` | Jump to line 5 |
| `Ctrl+d` | Page down |
| `Ctrl+u` | Page up |

### Editing

| Command | Action |
|---------|--------|
| `x` | Delete character under cursor |
| `dd` | Delete entire line |
| `dw` | Delete word |
| `d$` | Delete to end of line |
| `u` | Undo |
| `Ctrl+r` | Redo |
| `yy` | Copy (yank) entire line |
| `p` | Paste after cursor |
| `P` | Paste before cursor |

### Search

| Command | Action |
|---------|--------|
| `/pattern` | Search forward for "pattern" |
| `?pattern` | Search backward for "pattern" |
| `n` | Next search result |
| `N` | Previous search result |
| `Esc` | Clear search highlighting (custom) |

### Search and Replace

| Command | Action |
|---------|--------|
| `:s/old/new/` | Replace first "old" with "new" on current line |
| `:s/old/new/g` | Replace all "old" with "new" on current line |
| `:%s/old/new/g` | Replace all "old" with "new" in entire file |
| `:%s/old/new/gc` | Replace all with confirmation |

## Visual Mode (Selecting Text)

1. Press `v` to enter visual mode
2. Use navigation keys to select text
3. Then:
   - `d` to delete selection
   - `y` to copy selection
   - `>` to indent selection
   - `<` to unindent selection

## Common Workflows

### Edit a Git Commit Message

1. Vim opens with commit template
2. Press `i` to enter insert mode
3. Type your commit message
4. Press `Esc` (or `jk`) to exit insert mode
5. Type `:wq` to save and complete the commit

### Quick Find and Replace

1. Type `:%s/oldtext/newtext/gc`
2. Press `y` to replace, `n` to skip each occurrence
3. Press `Esc` when done

### Abandon Changes and Exit

1. Press `Esc` to ensure you're in normal mode
2. Type `:q!` to quit without saving

## Your Custom Settings

Your `.vimrc` includes these quality-of-life improvements:

- **Line numbers**: Relative numbers for easy jumping (`5j` goes down 5 lines)
- **2-space indents**: Matches your IDE settings
- **System clipboard**: `yy` copies to macOS clipboard
- **Mouse support**: Click to position cursor
- **Smart search**: Case-insensitive unless you use uppercase
- **`jk` shortcut**: Type `jk` quickly to exit insert mode (faster than reaching for Esc)

## Learning More

- Run `vimtutor` in terminal for an interactive tutorial (takes ~30 minutes)
- [Vim Cheat Sheet](https://vim.rtorr.com/)
- [OpenVim Tutorial](https://www.openvim.com/)

