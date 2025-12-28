# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository for a Linux system (Arch-based) using GNU Stow for symlink management. All configurations use the Catppuccin Mocha theme with blue accent. The primary desktop environment is Hyprland (Wayland compositor).

## Repository Architecture

### Stow-Based Management

This repository uses GNU Stow to manage dotfile symlinks:
- All configuration files are located in `.config/` directory
- `.stow-global-ignore` defines files that Stow should not symlink (README files, LICENSE, build scripts, git files)
- To deploy dotfiles: Run `stow` from the repository root to symlink all configs to `~/.config/`
- To build ble.sh (bash enhancement): `./build.sh` (runs `make -C ~/.config/bash/ble.sh install`)

### Git Submodules

Several plugin systems are managed as git submodules:
- **ZSH plugins**: autosuggestions, completions, syntax-highlighting, catppuccin theme, vi-mode
- **Tmux theme**: catppuccin-tmux
- **Other themes**: catppuccin-kvantum, catppuccin-wlogout
- **Bash enhancement**: ble.sh

To initialize submodules after clone:
```bash
git submodule update --init --recursive
```

## Shell Configurations

The repository supports multiple shells with shared tooling:

### Common Tools Across All Shells
- **starship**: Cross-shell prompt (initialized in all shells)
- **zoxide**: Smart directory jumping (initialized in all shells)
- **atuin**: Shell history sync and search (initialized in all shells)
- **fzf**: Fuzzy finder (initialized in all shells)
- **yazi**: Terminal file manager with shell integration (custom `y()` function to cd to last directory)

### Shell-Specific Details

**Fish** (`.config/fish/config.fish`):
- Primary shell with Catppuccin Mocha theme
- Vi mode enabled via `fish_vi_key_bindings`
- Auto-starts Hyprland on TTY1 if not in graphical session
- Auto-attaches to tmux session named "dev" in graphical environments
- Terminal integrations for both Ghostty and Kitty

**ZSH** (`.zshrc`):
- Vi mode enabled (`bindkey -v`)
- Plugins loaded from `.config/zsh/` submodules
- Atuin configured with vi keybindings (Ctrl+R in both insert and command mode)
- Terminal integrations for both Ghostty and Kitty

**Bash** (`.bashrc`):
- Vi mode enabled (`set -o vi`)
- Uses ble.sh for enhanced line editing (loaded with `--noattach` and attached at end)

**Nushell** (`.config/nushell/config.nu`):
- Modular configuration with separate files for each tool integration

### Common Aliases

All shells share similar aliases:
- **eza**: `l`, `ls`, `la` (with -a), `ll` (with -l), `lla` (with -la), `lt` (--tree)
- **nvim**: `v` for nvim, `vd` for `nvim -d` (diff mode)
- **git**: `gs` (status), `ga` (add), `gc` (commit), `gp` (push), `gl` (log), `gd` (diff)
- **navigation**: `..` (cd ..), `...` (cd ../..)
- **NixOS**: `sw` (nh os switch), `rsw` or `upd` (rebuild/update)
- **clear**: `c`

### Environment Variables

Important paths and settings (from fish config):
- `NH_OS_FLAKE="$HOME/nixos"`
- `NIXOS_CONFIG="$HOME/nixos"`
- PATH additions: `/usr/local/go/bin`, `/usr/local/nvim-linux-x86_64/bin`, `$HOME/.local/bin`, `$HOME/go/bin`, `$HOME/.venv/bin`
- `EDITOR="nvim"`

## Hyprland Configuration

The Hyprland config is documented separately in `.config/hypr/CLAUDE.md`. Key points:
- Modular structure with configs split across `hyprland/*.conf`
- Theme sourcing from `themes/mocha.conf`
- Reload config: `hyprctl reload`

## Neovim

- Uses LazyVim distribution
- Entry point: `.config/nvim/init.lua` (bootstraps lazy.nvim)
- Custom configs in `lua/config/` and `lua/plugins/`
- Plugins configured: dap, formatting, lsp, treesitter

## Tmux

Configuration: `.config/tmux/tmux.conf`
- Vi mode for copy and status keys
- Mouse support enabled
- Catppuccin Mocha theme (loaded from submodule)
- Status bar at top with minimal status-left and status-right
- Base index 1 for windows and panes
- Key bindings:
  - `&` - kill window
  - `x` - kill pane
  - `v` - enter copy mode
  - Vi-style selection in copy mode (v, y, Y)

## Waybar

Configuration: `.config/waybar/config.jsonc`
- Status bar for Hyprland
- Modules include: workspaces, language switcher, network, CPU, memory, temperature, battery, pulseaudio, clock
- Catppuccin Mocha styling in `mocha.css` and `style.css`

## Terminal Emulators

Two terminal emulators configured:
1. **Ghostty**: Theme at `.config/ghostty/themes/catppuccin-mocha`, custom tab styling
2. **Kitty**: Theme at `.config/kitty/catppuccin-mocha.conf`

Both have shell integration for fish and zsh.

## Common Modifications

When editing this repository:

**Adding a new shell plugin**:
- For zsh: Add as submodule in `.config/zsh/`, source in `.zshrc`
- For bash: Configure in `.bashrc` or `.config/bash/`
- For fish: Add to `.config/fish/config.fish`

**Changing themes**:
- All tools use Catppuccin Mocha with blue accent
- Theme files typically named `catppuccin-mocha.*` or located in `themes/` directories

**Modifying Hyprland**:
- See `.config/hypr/CLAUDE.md` for detailed guidance
- Edit specific module files in `hyprland/` directory

**Testing configurations**:
- Dotfiles are symlinked via Stow, so edits to files in this repo affect live configs
- For shells: Source the config file or restart the shell
- For Hyprland: `hyprctl reload`
- For tmux: Source config with `tmux source-file ~/.config/tmux/tmux.conf`
