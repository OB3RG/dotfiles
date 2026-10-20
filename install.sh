#!/usr/bin/env bash
set -euo pipefail

# Install stow if missing
command -v stow >/dev/null 2>&1 || {
    echo "Installing GNU stow..."
    sudo dnf install -y stow
}

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

# Make zsh the login shell
if [ "$SHELL" != "$(command -v zsh)" ] && command -v zsh >/dev/null 2>&1; then
    echo "Changing login shell to zsh..."
    chsh -s "$(command -v zsh)"
fi

echo ""
echo "Done!"
echo "Install dev packages with: ./install/packages.sh"
echo "Create ~/.zshrc.local and ~/.gitconfig.local for machine-specific overrides."
echo "For work setup: git clone <work-repo> ~/.dotfiles-work && cd ~/.dotfiles-work && stow ."
