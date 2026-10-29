#!/usr/bin/env bash
# Install every package: graphics, the GNOME desktop, dev tools and applications.
# One package set for all machines — the only per-machine difference is the GPU
# driver (NVIDIA laptop -> gpu-nvidia.sh; AMD/Intel need nothing beyond mesa).
#
# Run as root, either sourced from bootstrap.sh or standalone on a live system.
set -euo pipefail

# Package groups (kept together for readability):
#   graphics   - mesa covers AMD/Intel; NVIDIA is handled by gpu-nvidia.sh
#   desktop    - vanilla GNOME (Fedora-like curated set) + GDM login manager
#   portals    - screen sharing / screenshots / file choosers on Wayland
#   keyring    - gnome-keyring + gcr SSH agent (auto-unlocks at GDM login)
#   printing   - CUPS, used by GNOME Settings > Printers
#   fonts      - nerd font for ghostty + noto coverage (incl. emoji)
#   dev        - terminal, editor, shell and tooling
#   apps       - browser, documents, media, daily applications
#   utils      - clipboard, archives, system tools
#   security   - firewall, fail2ban
pacman -S --needed --noconfirm \
  mesa libva-mesa-driver libva-utils \
  gdm gnome-shell gnome-session gnome-settings-daemon gnome-control-center \
  gnome-backgrounds gnome-tweaks gnome-text-editor gnome-calculator \
  gnome-system-monitor gnome-disk-utility baobab \
  nautilus file-roller eog evince \
  xdg-desktop-portal-gnome xdg-desktop-portal-gtk \
  gnome-keyring libsecret gcr-4 seahorse \
  cups system-config-printer \
  power-profiles-daemon \
  ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji \
  ghostty neovim tree-sitter tree-sitter-cli zsh fzf go tmux ripgrep podman \
  firefox obsidian syncthing flatpak btop \
  zathura zathura-pdf-mupdf mpv \
  gvfs gvfs-smb wl-clipboard trash-cli fastfetch timeshift grub-btrfs \
  ufw fail2ban \
  kubectl sops talosctl

# Podman
systemctl enable podman.service

# Firewall (allow SSH before enabling)
ufw allow ssh
systemctl enable ufw

# Fail2ban
systemctl enable fail2ban

# GDM login manager -> GNOME session
systemctl enable gdm

# Printing
systemctl enable cups.socket

# GNOME power profiles (Performance / Balanced / Power Saver)
systemctl enable power-profiles-daemon

# grub-btrfs: Timeshift snapshots appear in the GRUB boot menu.
# The packaged daemon watches /.snapshots (snapper-style) — point it at
# Timeshift's runtime snapshot dir instead.
mkdir -p /etc/systemd/system/grub-btrfsd.service.d
cat > /etc/systemd/system/grub-btrfsd.service.d/override.conf <<'EOF'
[Service]
ExecStart=
ExecStart=/usr/bin/grub-btrfsd --syslog --timeshift-auto
EOF
systemctl enable grub-btrfsd

# Re-generate grub.cfg so the snapshots submenu is picked up — bootstrap.sh
# ran grub-mkconfig before this script was sourced.
if [ -d /boot/grub ]; then
  grub-mkconfig -o /boot/grub/grub.cfg
fi

echo "Packages installed."
echo "GDM is enabled — reboot gives you the graphical login -> GNOME."
