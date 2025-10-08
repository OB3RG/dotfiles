#!/usr/bin/env bash

if [ -z "$HOME" ]; then echo "Seems you're \$HOMEless :("; exit 1; fi

DOTCONFIG=$HOME/.config
DOTFILES=$HOME/.dotfiles

GITCLONE="git clone --depth=1"

cd "$HOME" || exit
rm -rf "$DOTFILES"
mkdir "$DOTFILES"
cd "$DOTFILES" || exit

git clone git@github.com:OB3RG/dotfiles.git $DOTFILES

rm -rf \
  "$HOME/.ssh/config" \
  "$HOME/.gitconfig" \
  "$HOME/.zshrc" \
  "$DOTCONFIG/btop" \
  "$DOTCONFIG/alacritty" \
  "$DOTCONFIG/nvim" \
  "$DOTCONFIG/tmux" \
  "$DOTCONFIG/gtk-3.0" \
  "$DOTCONFIG/gtk-4.0" \
  "$DOTCONFIG/hypr" \
  "$DOTCONFIG/swaync" \
  "$DOTCONFIG/waybar" \
  "$HOME/.zsh" 


ln -s "$DOTFILES/ssh/config" "$HOME/.ssh/config"
ln -s "$DOTFILES/gitconfig" "$HOME/.gitconfig"
ln -s "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
ln -s "$DOTFILES/zsh/plugins" "$HOME/.zsh"
ln -s "$DOTFILES/config/btop" "$DOTCONFIG/btop"
ln -s "$DOTFILES/config/alacritty" "$DOTCONFIG/alacritty"
ln -s "$DOTFILES/config/nvim" "$DOTCONFIG/nvim"
ln -s "$DOTFILES/config/tmux" "$DOTCONFIG/tmux"
ln -s "$DOTFILES/config/gtk-3.0" "$DOTCONFIG/gtk-3.0"
ln -s "$DOTFILES/config/gtk-4.0" "$DOTCONFIG/gtk-4.0"
ln -s "$DOTFILES/config/hypr" "$DOTCONFIG/hypr"
ln -s "$DOTFILES/config/swaync" "$DOTCONFIG/swaync"
ln -s "$DOTFILES/config/waybar" "$DOTCONFIG/waybar"

# Create local bin directory
mkdir -p "$HOME/.local/bin"

cd "$HOME" || exit
rm -f "${HOME}/.zcompdump*"

echo "ENJOY! :)"
echo "Note: Large binaries are no longer included in the repo."
echo "Run the installation scripts in ~/.dotfiles/scripts/ to install them."
