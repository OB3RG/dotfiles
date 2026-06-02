#!/usr/bin/env bash
# Install every package: graphics, the Sway desktop, dev tools and applications.
# One package set for all machines — the only per-machine difference is the GPU
# driver (NVIDIA laptop -> gpu-nvidia.sh; AMD/Intel need nothing beyond mesa).
#
# Run as root, either sourced from bootstrap.sh or standalone on a live system.
set -euo pipefail

# Package groups (kept together for readability):
#   graphics   - mesa covers AMD/Intel; NVIDIA is handled by gpu-nvidia.sh
#   desktop    - sway compositor + waybar + helpers (launcher, lock, screenshots)
#   greeter    - greetd; the tuigreet UI is in the AUR (installed by aur.sh)
#   fonts      - nerd fonts (sway uses JetBrainsMono) + font-awesome for waybar
#   dev        - terminal, editor, shell and tooling
#   apps       - browser, file manager, daily applications
pacman -S --needed --noconfirm \
  mesa libva-mesa-driver libva-utils \
  sway swaybg swayidle swaylock waybar fuzzel mako grim slurp wl-clipboard \
  xdg-desktop-portal-wlr xdg-desktop-portal-gtk polkit brightnessctl \
  greetd \
  ttf-jetbrains-mono-nerd ttf-cascadia-mono-nerd ttf-iosevka-nerd otf-font-awesome \
  alacritty neovim zsh fzf go tmux ripgrep docker \
  firefox thunar thunar-volman thunar-shares-plugin gvfs gvfs-smb \
  libsecret gnome-keyring gcr-4 blueman obsidian syncthing flatpak btop

# Docker
systemctl enable docker.service

# greetd: show tuigreet on tty1 and launch sway on login.
# Enabled later by aur.sh, once tuigreet is actually installed.
install -dm755 /etc/greetd
cat > /etc/greetd/config.toml <<'EOF'
[terminal]
vt = 1

[default_session]
command = "tuigreet --time --remember --cmd sway"
user = "greeter"
EOF

echo "Packages installed."
echo "tuigreet (the greeter UI) lives in the AUR — run install/aur.sh after first boot."
