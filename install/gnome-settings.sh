#!/usr/bin/env bash
# Apply GNOME settings: dark mode, Tokyo Night theme, ghostty as terminal.
# Run as the normal user, after install/aur.sh (theme must be installed).
set -euo pipefail

GTK_THEME="Tokyonight-Dark"

# --- Dark mode (libadwaita apps follow this) ---
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# --- Tokyo Night for GTK3 apps (run install/aur.sh first) ---
if [ -d "/usr/share/themes/$GTK_THEME" ]; then
  gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"

  # libadwaita (GTK4) apps ignore gtk-theme; give them the theme via user config
  mkdir -p "$HOME/.config/gtk-4.0"
  cp -rf "/usr/share/themes/$GTK_THEME/gtk-4.0/." "$HOME/.config/gtk-4.0/"
else
  echo "NOTE: $GTK_THEME not found in /usr/share/themes — run install/aur.sh first."
  echo "      Available variants: \$(ls /usr/share/themes | grep -i tokyo)"
fi

# --- ghostty as the default terminal ---
gsettings set org.gnome.desktop.default-applications.terminal exec 'ghostty'
gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''

echo "GNOME settings applied."
echo "Available Tokyo Night variants (restart gnome-tweaks to pick one):"
ls /usr/share/themes 2>/dev/null | grep -i tokyo || true
