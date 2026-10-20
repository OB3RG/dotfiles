#!/usr/bin/env zsh
export ZDOTDIR=$HOME/.zsh
export ZFILES=$HOME/.zsh

source $ZFILES/env
source $ZFILES/aliases

eval `dircolors $ZFILES/dircolors`

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

autoload -U compinit && compinit -u
zmodload -i zsh/complist

unsetopt menu_complete
unsetopt flowcontrol

setopt prompt_subst
setopt always_to_end
setopt append_history
setopt auto_menu
setopt complete_in_word
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt interactivecomments
setopt share_history
setopt auto_cd
setopt hist_find_no_dups
setopt hist_reduce_blanks

bindkey -v

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^f' autosuggest-accept

# fzf keybindings (Fedora path; fall back to Arch layout)
if [ -f /usr/share/fzf/shell/key-bindings.zsh ]; then
  source /usr/share/fzf/shell/key-bindings.zsh
elif [ -f /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
fi

fpath+=($ZFILES/my_prompt)
source $ZFILES/my_prompt/my_prompt

source $ZFILES/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZFILES/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Machine-specific overrides
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
