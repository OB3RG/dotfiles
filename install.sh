#!/usr/bin/env bash
set -euo pipefail

# Install stow if missing
command -v stow >/dev/null 2>&1 || {
    echo "Installing GNU stow..."
    sudo pacman -S --noconfirm stow
}

DOTFILES="$HOME/.dotfiles"

# Clone if needed
if [ ! -d "$DOTFILES/.git" ]; then
    git clone git@github.com:OB3RG/dotfiles.git "$DOTFILES"
fi

cd "$DOTFILES"
git submodule update --init --recursive

# Stow all packages
stow gitconfig zsh foot nvim tmux opencode ssh scripts sway

# Install large binaries
./install-packages.sh

echo ""
echo "Done!"
echo "Create ~/.zshrc.local and ~/.gitconfig.local for machine-specific overrides."
echo "For work setup: git clone <work-repo> ~/.dotfiles-work && cd ~/.dotfiles-work && stow ."
