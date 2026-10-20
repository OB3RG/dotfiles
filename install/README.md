# Fedora Install

Package setup for a Fedora (GNOME) machine. Fedora's installer handles
partitioning and the desktop; this only adds the dev environment.

## Scripts

| Script | Run as | When | Does |
|---|---|---|---|
| `packages.sh` | user (sudo) | anytime | Dev packages: neovim, tmux, zsh, fzf, ripgrep, go, podman, etc. |

## Setup

On a fresh Fedora Workstation install:

```bash
# 1. Clone the repo and stow all configs (installs stow, sets zsh as shell)
git clone https://github.com/OB3RG/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh

# 2. Install the dev packages
./install/packages.sh

# 3. Tools not packaged for Fedora (install to ~/.local/bin)
~/.local/bin/install-sops.sh
# kubectl if needed: sudo dnf install kubernetes1.35-client

# 4. Theme GNOME's terminal (Ptyxis) to match neovim's gruvbox
~/.local/bin/ptyxis-theme.sh

# 5. Log out and back in (shell change + keyring agent)
```

## Post-install extras

```bash
# SSH agent via gnome-keyring/gcr — already enabled by install.sh
# After first login, add your key once:
#   ssh-add ~/.ssh/id_rsa
# The keyring unlocks at login and caches the passphrase until reboot.
```
