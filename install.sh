#!/usr/bin/env bash
set -euo pipefail

# Install stow and zsh if missing
for pkg in stow zsh; do
    rpm -q "$pkg" >/dev/null 2>&1 || {
        echo "Installing $pkg..."
        sudo dnf install -y "$pkg"
    }
done

DOTFILES="$HOME/.dotfiles"

# Clone if needed
if [ ! -d "$DOTFILES/.git" ]; then
    git clone git@github.com:OB3RG/dotfiles.git "$DOTFILES"
fi

cd "$DOTFILES"
git submodule update --init --recursive

# Stow all packages (--restow makes this idempotent)
stow --restow gitconfig zsh nvim tmux ssh scripts

# GNOME Keyring: SSH agent (unlocks at login, caches passphrase)
systemctl --user enable --now gnome-keyring-daemon.service
systemctl --user enable --now gcr-ssh-agent.socket

# Create standard home directories
xdg-user-dirs-update

# Make zsh the login shell (check /etc/passwd, not $SHELL)
ZSH_PATH="$(command -v zsh)"
CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"
if [ "$CURRENT_SHELL" != "$ZSH_PATH" ]; then
    echo "Changing login shell from $CURRENT_SHELL to $ZSH_PATH..."
    sudo chsh -s "$ZSH_PATH" "$USER"
    echo "Shell changed — log out and back in for it to take effect."
else
    echo "Login shell is already zsh."
fi

echo ""
echo "Done!"
echo "Install dev packages with: ./install/packages.sh"
echo "Create ~/.zshrc.local and ~/.gitconfig.local for machine-specific overrides."
echo "For work setup: git clone <work-repo> ~/.dotfiles-work && cd ~/.dotfiles-work && stow ."
