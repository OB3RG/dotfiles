#!/usr/bin/env bash
# Install dev packages on Fedora (GNOME desktop is provided by the OS install).
# Run as the normal user; sudo is used where needed.
set -euo pipefail

# RPM Fusion (free + nonfree) — media codecs, Steam, etc. Idempotent.
sudo dnf install -y \
  "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
  "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

# Package groups (kept together for readability):
#   dotfiles   - stow manages the symlinks
#   dev        - editor, shell and tooling
#   nix        - the Nix package manager (nix-shell); daemon is socket-activated
#   utils      - clipboard (Wayland), system monitoring
sudo dnf install -y \
  stow git \
  zsh fzf ripgrep tmux neovim tree-sitter-cli \
  golang podman gh \
  nix \
  wl-clipboard btop fastfetch

# Nix multi-user daemon (socket-activated; provides nix-shell etc.)
sudo systemctl enable --now nix-daemon.socket

# Optional: kubectl (Fedora ships versioned client packages)
# sudo dnf install -y kubernetes1.35-client
# or get the latest upstream binary: ~/.local/bin/install-kubectl.sh

# sops is not packaged for Fedora — install it to ~/.local/bin:
#   ~/.local/bin/install-sops.sh

echo "Packages installed."
echo "Log out and back in for the nix profile to land in PATH."
