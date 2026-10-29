#!/usr/bin/env bash
# Apply GNOME settings: dark mode, Tokyo Night theme, ghostty as terminal.
# Run as the normal user, after install/theme-tokyonight.sh.
set -euo pipefail

GTK_THEME="Tokyonight-Dark"

# --- Dark mode (libadwaita apps follow this) ---
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# --- Tokyo Night for GTK3 apps ---
# (GTK4/libadwaita theming is handled by theme-tokyonight.sh's --libadwaita links)
if [ -d "$HOME/.themes/$GTK_THEME" ] || [ -d "/usr/share/themes/$GTK_THEME" ]; then
  gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
else
  echo "NOTE: $GTK_THEME not found — run install/theme-tokyonight.sh first."
  echo "      Installed variants: $(ls "$HOME/.themes" 2>/dev/null | grep -i tokyo | tr '\n' ' ')"
fi

# --- ghostty as the default terminal ---
gsettings set org.gnome.desktop.default-applications.terminal exec 'ghostty'
gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''

echo "GNOME settings applied (dark mode, $GTK_THEME, ghostty terminal)."
