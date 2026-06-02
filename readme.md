# Dotfiles

My personal configuration files for a complete development environment, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

Each top-level directory is a stow package. The internal structure mirrors the target path from `$HOME`.

| Package | Target | Description |
|---|---|---|
| `gitconfig/` | `~/.gitconfig` | Git configuration |
| `zsh/` | `~/.zshrc`, `~/.zsh/` | Zsh shell configuration |
| `foot/` | `~/.config/foot/` | Terminal emulator |
| `nvim/` | `~/.config/nvim/` | Neovim editor |
| `tmux/` | `~/.config/tmux/` | Terminal multiplexer |
| `opencode/` | `~/.config/opencode/` | OpenCode AI config |
| `ssh/` | `~/.ssh/config` | SSH configuration |
| `scripts/` | `~/.local/bin/` | Utility scripts |
| `sway/` | `~/.config/sway/` | Wayland compositor |

## Installation

### Fresh machine (from the Arch ISO)

To install Arch from scratch — base system, the Sway desktop and all packages —
follow [`install/README.md`](install/README.md). One package set covers every
machine; the only per-machine difference is the NVIDIA driver (laptop).

### Existing system (dotfiles only)

```bash
./install.sh
```

This will:
1. Install GNU stow if not present
2. Clone the repo to `~/.dotfiles`
3. Initialize git submodules (zsh plugins)
4. Stow all packages
5. Install large binaries (kubectl, sops, talosctl)

### Manual setup

```bash
# Install stow
sudo pacman -S stow

# Clone and stow
git clone git@github.com:OB3RG/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule update --init --recursive
stow gitconfig zsh foot nvim tmux opencode ssh scripts sway
```

## Machine-Specific Configuration

No branches needed. Each config sources a `.local` file if it exists (gitignored):

- `~/.zshrc.local` — machine-specific zsh overrides
- `~/.gitconfig.local` — machine-specific git settings (email, etc.)
- `~/.config/sway/config.local` — machine-specific sway settings (outputs, scaling)
- `~/.config/opencode/opencode.local.json` — API keys and secrets

Example `~/.gitconfig.local`:
```ini
[user]
    email = your-email@example.com
```

Example `~/.zshrc.local`:
```zsh
export PATH=$PATH:/some/machine/specific/path
```

## Work Configuration

Work configs live in a separate private repository:

```bash
git clone git@github.com:OB3RG/dotfiles-work.git ~/.dotfiles-work
cd ~/.dotfiles-work
stow .
```

The work repo contains:
- `~/.gitconfig-work` — work email, credential helper (includes personal gitconfig)
- `~/.zshrc.local` — work PATH, work aliases
- `~/.ssh/config.d/` — work SSH hosts

## Notable

- No credentials or API keys are stored in this public repository
- No large binaries — install scripts in `~/.local/bin/` handle downloads
- Zsh plugins are managed as git submodules, not vendored
