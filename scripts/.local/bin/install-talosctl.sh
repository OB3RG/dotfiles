#!/usr/bin/env bash

# Install talosctl binary
set -e

echo "Installing talosctl..."

# Get the latest release version
TALOSCTL_VERSION=$(curl -s https://api.github.com/repos/siderolabs/talos/releases/latest | grep tag_name | cut -d '"' -f 4)

# Download talosctl binary
curl -LO "https://github.com/siderolabs/talos/releases/download/${TALOSCTL_VERSION}/talosctl-linux-amd64"

# Make it executable
chmod +x talosctl-linux-amd64

# Move to local bin directory
mkdir -p "${HOME}/.local/bin"
mv talosctl-linux-amd64 "${HOME}/.local/bin/talosctl"

echo "talosctl installed successfully to ~/.local/bin/talosctl"