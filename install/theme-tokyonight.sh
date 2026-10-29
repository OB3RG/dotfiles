#!/usr/bin/env bash
# Install the Tokyo Night GTK theme straight from GitHub — no AUR.
# Run as the normal user (NOT root), after the first boot.
set -euo pipefail

if [ "$(id -u)" -eq 0 ]; then
  echo "Run this as your normal user, not root." >&2
  exit 1
fi

# sassc compiles the theme's CSS (from the official repos)
sudo pacman -S --needed --noconfirm sassc

# Keep the clone around so re-running this script updates the theme
SRC_DIR="$HOME/.local/src/Tokyonight-GTK-Theme"
if [ -d "$SRC_DIR/.git" ]; then
  git -C "$SRC_DIR" pull --ff-only
else
  mkdir -p "$(dirname "$SRC_DIR")"
  git clone --depth 1 https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme.git "$SRC_DIR"
fi

# Dark variant only, standard size.
# --libadwaita links the GTK4 theme into ~/.config/gtk-4.0 so libadwaita
# apps (Files, Text Editor, ...) also follow the theme.
"$SRC_DIR/themes/install.sh" --color Dark --size standard --libadwaita

echo
echo "Tokyo Night theme installed to ~/.themes"
echo "Apply it with: ./install/gnome-settings.sh"
