# Dotfiles

My personal configuration files for a complete development environment.

## Structure

- `assets/` - Images and other media assets
- `config/` - Configuration files for various applications
- `install/` - Installation scripts for setting up systems
- `scripts/` - Utility scripts for various tasks
- `ssh/` - SSH configuration
- `zsh/` - Zsh configuration and plugins

## Installation

1. Run `./install.sh` to set up symlinks
2. Run `./install-packages.sh` to install required packages and binaries

## Notable Changes

Large binary files (kubectl, sops, talosctl) are no longer included in the repository to reduce size. 
Installation scripts for these binaries are available in the `scripts/` directory.