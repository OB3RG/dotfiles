#!/usr/bin/env bash

if [ -z "$HOME" ]; then echo "Seems you're \$HOMEless :("; exit 1; fi

DOTCONFIG=$HOME/.config
DOTFILES=$HOME/.dotfiles
DOTFZF=$HOME/.fzf
DOTLOCAL=$HOME/.local/share/dotfiles

GITCLONE="git clone --depth=1"

cd "$HOME" || exit
rm -rf "$DOTFILES"
mkdir "$DOTFILES"
cd "$DOTFILES" || exit

git clone git@github.com:OB3RG/dotfiles.git $DOTFILES

rm -rf \
  "$DOTFZF" \
  "$DOTLOCAL" \
  "$HOME/.bashrc" \
  "$HOME/.gitconfig" \
  "$HOME/.zshrc" \
  "$HOME/.config/starship.toml" \
  "$HOME/.config/nvim"


mkdir -p \
  "$DOTLOCAL" \

ln -s "$DOTFILES/bashrc" "$HOME/.bashrc"
ln -s "$DOTFILES/gitconfig" "$HOME/.gitconfig"
ln -s "$DOTFILES/zshrc" "$HOME/.zshrc"
ln -s "$DOTFILES/gitconfig" "$HOME/.gitconfig"
ln -s "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"
ln -s "$DOTFILES/nvim" "$HOME/.config/nvim"

$GITCLONE https://github.com/junegunn/fzf.git "$DOTFZF"
"$DOTFZF/install" --key-bindings --completion --no-update-rc

ZSHPLUGS=(
  "zsh-completions"
  "zsh-history-substring-search"
  "zsh-syntax-highlighting"
)

for INDEX in ${!ZSHPLUGS[*]}; do
  ZSHPLUG="${ZSHPLUGS[$INDEX]}"
  $GITCLONE "https://github.com/zsh-users/$ZSHPLUG.git" "$DOTLOCAL/$ZSHPLUG"
done

cd "$HOME" || exit
rm -f "${HOME}/.zcompdump*"

echo "ENJOY! :)"

