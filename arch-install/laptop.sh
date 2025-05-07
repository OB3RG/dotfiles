#!/bin/bash

pacman -S --noconfirm tlp mesa nvidia-open-dkms nvidia-utils nvidia-settings libva-mesa-driver vainfo egl-wayland

systemctl enable tlp 
