#!/usr/bin/env bash
# Apply the Gruvbox palette to GNOME's terminal (Ptyxis on Fedora), matching
# neovim's gruvbox colorscheme. The palette is bundled with Ptyxis and follows
# the GNOME dark/light style. Safe to re-run.
set -euo pipefail

uuid=$(gsettings get org.gnome.Ptyxis default-profile-uuid | tr -d "'")
if [ -z "$uuid" ]; then
    echo "No Ptyxis default profile found — open the Terminal app once, then re-run." >&2
    exit 1
fi

gsettings set "org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/profiles/${uuid}/" palette 'Gruvbox'

echo "Ptyxis profile $uuid now uses the Gruvbox palette."
