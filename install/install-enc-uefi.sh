#!/bin/bash

# Set timezone and hardware clock
ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc

# Configure locale
sed -i '171s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf

# Configure hostname and hosts
echo "oberg" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 oberg.localdomain oberg" >> /etc/hosts

# Set root password
echo root:password | chpasswd

# Create a key file to prevent double password entry
dd bs=512 count=4 if=/dev/urandom of=/crypto_keyfile.bin
chmod 000 /crypto_keyfile.bin

# Add the crypto keyfile to the FILES array in mkinitcpio.conf
sed -i 's/^FILES=()/FILES=(\/crypto_keyfile.bin)/' /etc/mkinitcpio.conf

# Configure mkinitcpio for LVM on LUKS
sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt lvm2 filesystems keyboard fsck)/' /etc/mkinitcpio.conf

# Install necessary packages
pacman -Syy
pacman -S --noconfirm grub efibootmgr base-devel linux-headers xdg-user-dirs xdg-utils openssh reflector acpi acpi_call acpid \
          networkmanager iw wpa_supplicant iputils network-manager-applet \
          alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol \
          bluez bluez-utils \
          sudo man-db man dialog \
          lvm2

# Configure GRUB for encrypted boot
echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub

# Get the UUID of the encrypted partition (assuming it's the third partition on the first disk)
# This assumes the partitioning was done according to the encryption-partitioning-guide.md
root_uuid=$(blkid -s UUID -o value /dev/nvme0n1p3 2>/dev/null)

# If we couldn't find the UUID, try to find any LUKS partition
if [ -z "$root_uuid" ]; then
    root_uuid=$(lsblk -f | grep crypto_LUKS | head -1 | awk '{print $3}')
fi

# Configure GRUB to boot from encrypted partition
if [ -n "$root_uuid" ]; then
    sed -i "s/GRUB_CMDLINE_LINUX=\"\"/GRUB_CMDLINE_LINUX=\"cryptdevice=UUID=$root_uuid:cryptlvm root=\/dev\/mapper\/vg0-root\"/" /etc/default/grub
else
    # Fallback - user will need to manually configure this
    echo "WARNING: Could not detect encrypted partition UUID. You'll need to manually configure /etc/default/grub"
    echo "GRUB_CMDLINE_LINUX=\"cryptdevice=UUID=<your-luks-uuid>:cryptlvm root=/dev/mapper/vg0-root\"" >> /etc/default/grub
fi

# Generate initramfs
mkinitcpio -P linux

# Install GRUB bootloader
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

# Generate GRUB configuration
grub-mkconfig -o /boot/grub/grub.cfg

# Enable system services
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable acpid

# Create user
useradd -m oberg
echo oberg:password | chpasswd

# Grant sudo privileges
echo "oberg ALL=(ALL) ALL" >> /etc/sudoers.d/oberg

# Initialize pacman keys
pacman -S --noconfirm archlinux-keyring
pacman-key --init
pacman-key --populate archlinux

# Source additional configuration scripts
source ./hyprland.sh
source ./dev.sh
source ./general.sh

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
