#!/bin/bash

pacman -S --noconfirm hyprland hyprpaper hypridle hyprlock xdg-desktop-portal-hyprland sddm

systemctl enable sddm
