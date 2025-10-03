#!/usr/bin/env bash

# Install kubectl binary
set -e

echo "Installing kubectl..."

# Determine the latest version
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)

# Download kubectl binary
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

# Make it executable
chmod +x kubectl

# Move to local bin directory
mkdir -p "${HOME}/.local/bin"
mv kubectl "${HOME}/.local/bin/"

echo "kubectl installed successfully to ~/.local/bin/kubectl"