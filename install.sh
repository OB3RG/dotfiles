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
stow gitconfig zsh foot nvim tmux opencode ssh scripts sway kanshi qt

# Verify key symlinks and repair if needed
verify_symlink() {
    local target="$1"
    if [ -L "$target" ]; then
        echo "  OK: $target (symlink)"
    elif [ -e "$target" ]; then
        echo "  WARN: $target exists but is not a symlink — repairing..."
        return 1
    else
        echo "  WARN: $target is missing — repairing..."
        return 1
    fi
    return 0
}

echo ""
echo "Verifying symlinks..."
REPAIR_NEEDED=false

verify_symlink "$HOME/.config/waybar/config" || REPAIR_NEEDED=true
verify_symlink "$HOME/.config/sway/config" || REPAIR_NEEDED=true
verify_symlink "$HOME/.config/kanshi/config" || REPAIR_NEEDED=true

if [ "$REPAIR_NEEDED" = true ]; then
    echo ""
    echo "Some symlinks were missing or incorrect. Re-stowing to fix..."
    stow --restow gitconfig zsh foot nvim tmux opencode ssh scripts sway kanshi qt
    echo "Re-stow complete. Verifying again..."

    ALL_OK=true
    verify_symlink "$HOME/.config/waybar/config" || ALL_OK=false
    verify_symlink "$HOME/.config/sway/config" || ALL_OK=false
    verify_symlink "$HOME/.config/kanshi/config" || ALL_OK=false

    if [ "$ALL_OK" = true ]; then
        echo "All symlinks verified successfully."
    else
        echo "ERROR: Some symlinks still could not be created. Check for conflicts."
        exit 1
    fi
else
    echo "All symlinks verified successfully."
fi

# GNOME Keyring: SSH agent (unlocks at login, caches passphrase)
systemctl --user enable --now gnome-keyring-daemon.service
systemctl --user enable --now gcr-ssh-agent.socket

# Create standard home directories
xdg-user-dirs-update

# Set Thunar as the default file manager for directories
xdg-mime default thunar.desktop inode/directory

echo ""
echo "Done!"
echo "Create ~/.zshrc.local and ~/.gitconfig.local for machine-specific overrides."
echo "For work setup: git clone <work-repo> ~/.dotfiles-work && cd ~/.dotfiles-work && stow ."
