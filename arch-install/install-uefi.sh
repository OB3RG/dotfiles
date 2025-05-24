#!/bin/bash

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

pacman -Syy
pacman -S --noconfirm grub efibootmgr base-devel linux-headers xdg-user-dirs xdg-utils openssh reflector acpi acpi_call acpid \
          networkmanager iw wpa_supplicant iputils network-manager-applet \
          alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol \
          bluez bluez-utils \
          sudo man-db man dialog

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
printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

