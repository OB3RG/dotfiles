# Dotfiles

My personal configuration files for a Fedora development environment, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

Each top-level directory is a stow package. The internal structure mirrors the target path from `$HOME`.

| Package | Target | Description |
|---|---|---|
| `gitconfig/` | `~/.gitconfig` | Git configuration |
| `zsh/` | `~/.zshrc`, `~/.zsh/` | Zsh shell configuration |
| `nvim/` | `~/.config/nvim/` | Neovim editor |
| `tmux/` | `~/.config/tmux/` | Terminal multiplexer |
| `ssh/` | `~/.ssh/config` | SSH configuration |
| `scripts/` | `~/.local/bin/` | Utility scripts |

## Installation

### Fresh Fedora machine

Fedora's installer handles the base system and the GNOME desktop. Then follow
[`install/README.md`](install/README.md) — in short:

```bash
git clone https://github.com/OB3RG/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh            # stows everything, sets zsh as login shell
./install/packages.sh   # dev packages via dnf
```

### What install.sh does

1. Installs GNU stow if not present
2. Clones the repo to `~/.dotfiles` (when run standalone)
3. Initializes git submodules (zsh plugins)
4. Stows all packages (idempotent via `--restow`)
5. Enables the GNOME Keyring SSH agent
6. Changes the login shell to zsh

### Manual setup

```bash
# Install stow
sudo dnf install stow

# Clone and stow
git clone git@github.com:OB3RG/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule update --init --recursive
stow gitconfig zsh nvim tmux ssh scripts
```

## GNOME Terminal theme

Fedora's terminal app is Ptyxis. `~/.local/bin/ptyxis-theme.sh` sets its
palette to the bundled **Gruvbox** theme so the terminal matches neovim's
colorscheme (it follows the GNOME dark/light style automatically).

## Machine-Specific Configuration

No branches needed. Each config sources a `.local` file if it exists (gitignored):

- `~/.zshrc.local` — machine-specific zsh overrides
- `~/.gitconfig.local` — machine-specific git settings (email, etc.)

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
- No large binaries — install scripts in `~/.local/bin/` handle downloads (sops is not packaged for Fedora)
- Zsh plugins are managed as git submodules, not vendored
