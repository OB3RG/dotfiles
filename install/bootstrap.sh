#!/usr/bin/env bash
# Arch Linux base system bootstrap.
# Run INSIDE arch-chroot as root, after pacstrap + genfstab (see README.md).
# Sets up locale, users, bootloader and networking, then installs all packages.
set -euo pipefail

cd "$(dirname "$0")"

# --- Timezone & clock ---
ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc

# --- Locale ---
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf

# --- Hostname & hosts ---
echo "oberg" > /etc/hostname
cat > /etc/hosts <<'EOF'
127.0.0.1 localhost
::1       localhost
127.0.1.1 oberg.localdomain oberg
EOF

# --- Base system ---
pacman -Syy
pacman -S --noconfirm \
  grub efibootmgr base-devel linux-headers xdg-user-dirs xdg-utils openssh reflector acpi acpi_call acpid \
  networkmanager iw wpa_supplicant iputils network-manager-applet \
  alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol \
  bluez bluez-utils \
  sudo man-db man-pages dialog git stow

# --- Bootloader ---
# NOTE: if you mounted the EFI partition at /boot/efi, change --efi-directory accordingly.
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# --- Services ---
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable acpid

# --- User ---
useradd -m -G wheel oberg
echo ">> Set a password for user 'oberg':"
passwd oberg
echo ">> Set the root password:"
passwd root
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# --- Keyring ---
pacman -S --noconfirm archlinux-keyring
pacman-key --init
pacman-key --populate archlinux

# --- Desktop + applications ---
source ./packages.sh

printf "\n\e[1;32mBase install done.\e[0m\n"
echo "Next steps:"
echo "  - (laptop only) run: ./gpu-nvidia.sh"
echo "  - type 'exit', then 'umount -R /mnt', then 'reboot'"
echo "  - after reboot, log in as 'oberg' and follow the post-install steps in install/README.md"
