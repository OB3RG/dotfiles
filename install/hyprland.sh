#!/bin/bash

pacman -S --noconfirm hyprland hyprpaper hypridle hyprlock xdg-desktop-portal-hyprland sddm waybar otf-font-awesome wofi ttf-cascadia-mono-nerd ttf-iosevka-nerd

systemctl enable sddm
