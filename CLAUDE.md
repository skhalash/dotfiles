# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles managed with [dotbot](https://github.com/anishathalye/dotbot). Running `./install` symlinks config files into the correct locations and bootstraps the machine.

## Key commands

```bash
# Apply dotfiles (symlink everything, run shell scripts)
./install

# Apply dotfiles but skip shell steps (safe for incremental updates)
./install --except shell

# Update dotfiles + Homebrew packages + zsh plugins
update   # alias defined in lib/aliases.zsh; sources scripts/update
```

## Architecture

**`install.conf.yaml`** — the single source of truth for what gets symlinked where. Edit this to add/remove managed configs.

**Symlink targets** (what `./install` creates):

| Source | Symlinked to |
|--------|-------------|
| `~/.zshrc` | `zshrc` |
| `~/.gitconfig` | `gitconfig` |
| `~/.tmux.conf` | `tmux.conf` |
| `~/.config/nvim/` | `nvim/` |
| `~/.config/lsd/` | `lsd/` |
| `~/.config/k9s/` | `k9s/` |
| `~/.config/zed/` | `zed/*` (excluding `conversations/` and `prompts/`) |
| `~/Library/Application Support/lazygit/config.yml` | `lazygit.yml` |
| `~/Library/Application Support/Code/User/settings.json` | `vscode/settings.json` |

**`zshrc`** — loads zgen (plugin manager at `~/.zgen/`), sources `lib/*.zsh`, configures Spaceship prompt. Plugins auto-update when `zshrc` or any `lib/*.zsh` file changes.

**`lib/aliases.zsh`** — all shell aliases. This is where new aliases belong.

**`nvim/`** — Neovim config using [lazy.nvim](https://github.com/folke/lazy.nvim). Entry point is `init.lua`; plugins are in `lua/lazy-plugins.lua`; custom lua modules are in `lua/custom/`.

**`scripts/bootstrap.osx`** — run once on a new Mac: installs Homebrew, Git, runs `brew bundle`, configures iTerm2, installs VSCode extensions.

**`Brewfile`** — all Homebrew packages and casks. Run `brew bundle` to install from it.

## Adding a new dotfile

1. Place the config file in this repo.
2. Add a `link:` entry in `install.conf.yaml` mapping the target path to the source.
3. Run `./install` to apply.

## Zsh plugin management

Plugins are managed by [zgen](https://github.com/tarjoilija/zgen). The saved init script is regenerated automatically when `~/.zshrc` or `lib/*.zsh` changes. To force a rebuild manually, delete `~/.zgen/init.zsh` and reload the shell.
