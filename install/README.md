# Fedora Install

Package setup for Fedora with GNOME or KDE Plasma. Fedora's installer handles
partitioning and the desktop; this only adds the dev environment.

## Scripts

| Script | Run as | When | Does |
|---|---|---|---|
| `packages.sh` | user (sudo) | anytime | Dev packages: Alacritty, neovim, tmux, zsh, fzf, ripgrep, go, podman, etc. |

## Setup

On a fresh Fedora install:

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

# 4. GNOME only: theme Ptyxis to match Neovim's Gruvbox colorscheme
# (Alacritty on KDE is already themed by its stowed configuration.)
if [[ "$XDG_CURRENT_DESKTOP" == *GNOME* ]]; then
  ~/.local/bin/ptyxis-theme.sh
fi

# 5. Log out and back in (shell change; keyring agent on GNOME)
```

## Post-install extras

```bash
# On GNOME, the SSH agent via gnome-keyring/gcr is enabled by install.sh.
# On KDE, an existing desktop SSH agent is left untouched.
# After first login, add your key once:
#   ssh-add ~/.ssh/id_rsa
# GNOME's keyring unlocks at login and caches the passphrase until reboot.
```
