#!/usr/bin/env bash
# Install AUR packages and finish greeter setup.
# Run as the normal user (NOT root), after the first boot.
set -euo pipefail

if [ "$(id -u)" -eq 0 ]; then
  echo "Run this as your normal user, not root." >&2
  exit 1
fi

# Bootstrap the paru AUR helper if it's missing.
if ! command -v paru >/dev/null 2>&1; then
  sudo pacman -S --needed --noconfirm base-devel git
  tmp="$(mktemp -d)"
  git clone https://aur.archlinux.org/paru.git "$tmp/paru"
  ( cd "$tmp/paru" && makepkg -si --noconfirm )
  rm -rf "$tmp"
fi

# AUR packages
paru -S --needed --noconfirm greetd-tuigreet gruvbox-dark-gtk

# Enable the login greeter now that tuigreet is present.
sudo systemctl enable greetd

echo "AUR packages installed and greetd enabled."
echo "Reboot to get the tuigreet login -> sway."
