#!/usr/bin/env bash

# Install sops binary
set -e

echo "Installing sops..."

# Get the latest release version
SOPS_VERSION=$(curl -s https://api.github.com/repos/getsops/sops/releases/latest | grep tag_name | cut -d '"' -f 4)

# Download sops binary
curl -LO "https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.amd64"

# Make it executable
chmod +x "sops-${SOPS_VERSION}.linux.amd64"

# Move to local bin directory
mkdir -p "${HOME}/.local/bin"
mv "sops-${SOPS_VERSION}.linux.amd64" "${HOME}/.local/bin/sops"

echo "sops installed successfully to ~/.local/bin/sops"