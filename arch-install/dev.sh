#!/bin/bash

pacman -S --noconfirm alacritty neovim zsh fzf go tmux ripgrep docker

systemctl enable docker.service
