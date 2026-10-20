#!/usr/bin/env bash

if [[ "$(pwd)" == $HOME/Work ]]; then
    clear
    exit 0
fi
tmux new-window -dn scratch
vim .
clear
