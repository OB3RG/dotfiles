#!/bin/bash

pacman -S --noconfirm alacritty neovim zsh fzf go ripgrep docker

systemctl enable docker.service
