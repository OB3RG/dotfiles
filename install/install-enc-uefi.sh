#!/bin/bash

set -euo pipefail

ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc
sed -i '171s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf
echo "oberg" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 oberg.localdomain oberg" >> /etc/hosts
echo root:password | chpasswd

# Create a key file to prevent double password entry
dd bs=512 count=4 if=/dev/urandom of=/crypto_keyfile.bin
chmod 000 /crypto_keyfile.bin

# Add the crypto keyfile to the FILES array in mkinitcpio.conf
sed -i 's/^FILES=()/FILES=(\/crypto_keyfile.bin)/' /etc/mkinitcpio.conf

# Configure mkinitcpio for LVM on LUKS
# Follow the gist approach with proper hook ordering
sed -i 's/HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck)/HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems keyboard fsck shutdown)/' /etc/mkinitcpio.conf

pacman -Syy
pacman -S --noconfirm grub efibootmgr base-devel linux-headers xdg-user-dirs xdg-utils openssh reflector acpi acpi_call acpid \
          networkmanager iw wpa_supplicant iputils network-manager-applet \
          alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol \
          bluez bluez-utils \
          sudo man-db man dialog

# Configure GRUB for encrypted boot
echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub
root_uuid=$(blkid -s UUID -o value /dev/nvme0n1p2)
sed -i "s/GRUB_CMDLINE_LINUX=\"\"/GRUB_CMDLINE_LINUX=\"cryptdevice=UUID=$root_uuid:cryptlvm root=\/dev\/MainGroup\/root\"/" /etc/default/grub

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable acpid

useradd -m oberg
echo oberg:password | chpasswd

echo "oberg ALL=(ALL) ALL" >> /etc/sudoers.d/oberg

pacman -S --noconfirm archlinux-keyring
pacman-key --init
pacman-key --populate archlinux

source ./hyprland.sh
source ./dev.sh
source ./general.sh

mkinitcpio -P
printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

