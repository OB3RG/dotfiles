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
  "$DOTCONFIG/alacritty" \
  "$DOTCONFIG/nvim" \
  "$DOTCONFIG/tmux" \
  "$DOTCONFIG/opencode" \
  "$HOME/.zsh" 


ln -s "$DOTFILES/ssh/config" "$HOME/.ssh/config"
ln -s "$DOTFILES/gitconfig" "$HOME/.gitconfig"
ln -s "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
ln -s "$DOTFILES/zsh/plugins" "$HOME/.zsh"
ln -s "$DOTFILES/config/alacritty" "$DOTCONFIG/alacritty"
ln -s "$DOTFILES/config/nvim" "$DOTCONFIG/nvim"
ln -s "$DOTFILES/config/tmux" "$DOTCONFIG/tmux"
ln -s "$DOTFILES/config/opencode" "$DOTCONFIG/opencode"

# Create local bin directory
mkdir -p "$HOME/.local/bin"

cd "$HOME" || exit
rm -f "${HOME}/.zcompdump*"

echo "ENJOY! :)"
echo "Run the installation scripts in ~/.dotfiles/scripts/ to install additional tooling"
