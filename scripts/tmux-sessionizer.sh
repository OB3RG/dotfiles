#!/usr/bin/env bash

if [[ "$(pwd)" == $HOME/Work ]]; then
    clear
    return
fi
tmux new-window -dn scratch
vim .
clear
