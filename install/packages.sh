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
#   theme      - gruvbox GTK theme (AUR), papirus icons, qt config
#   dev        - terminal, editor, shell and tooling
#   apps       - browser, file manager, daily applications
#   utils      - clipboard, media, archives, system tools
#   security   - firewall, fail2ban
pacman -S --needed --noconfirm \
  mesa libva-mesa-driver libva-utils \
  sway swaybg swayidle swaylock waybar wofi mako grim slurp wl-clipboard cliphist \
  xdg-desktop-portal-wlr xdg-desktop-portal-gtk polkit brightnessctl \
  kanshi \
  greetd \
  ttf-jetbrains-mono-nerd ttf-cascadia-mono-nerd ttf-iosevka-nerd otf-font-awesome \
  papirus-icon-theme qt5ct qt6ct \
  foot neovim zsh fzf go tmux ripgrep podman \
  firefox nautilus gvfs gvfs-smb \
  libsecret gnome-keyring gcr-4 blueman obsidian syncthing flatpak btop \
  zathura zathura-pdf-mupdf mpv swayimg trash-cli \
  playerctl pamixer \
  ufw fail2ban fastfetch timeshift

# Podman
systemctl enable podman.service

# Firewall (allow SSH before enabling)
ufw allow ssh
systemctl enable ufw

# Fail2ban
systemctl enable fail2ban

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
