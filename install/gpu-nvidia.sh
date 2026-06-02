#!/usr/bin/env bash
# Optional: NVIDIA drivers + laptop power management.
# This is the ONLY package difference between machines — desktops (AMD/Intel)
# need nothing beyond the mesa already installed by packages.sh.
#
# Run as root, either in chroot during install or on the running system.
set -euo pipefail

pacman -S --needed --noconfirm \
  nvidia-dkms nvidia-utils nvidia-settings \
  egl-wayland

# Laptop power management
pacman -S --needed --noconfirm tlp
systemctl enable tlp

cat <<'EOF'
NVIDIA drivers installed.

For Sway/Wayland on NVIDIA, enable DRM kernel mode setting:
  1. Add 'nvidia_drm.modeset=1' to GRUB_CMDLINE_LINUX_DEFAULT in /etc/default/grub
  2. grub-mkconfig -o /boot/grub/grub.cfg
  3. Launch sway with the '--unsupported-gpu' flag if it refuses to start.
EOF
