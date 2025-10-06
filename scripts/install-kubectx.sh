#!/usr/bin/env bash

set -e

echo "Installing kubectx and kubens..."

KUBECTX_VERSION=$(curl -s https://api.github.com/repos/ahmetb/kubectx/releases/latest | grep tag_name | cut -d '"' -f 4)

curl -LO "https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubectx"
curl -LO "https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubens"

chmod +x kubectx kubens

mkdir -p "${HOME}/.local/bin"
mv kubectx "${HOME}/.local/bin/"
mv kubens "${HOME}/.local/bin/"

echo "kubectx and kubens installed successfully to ~/.local/bin/"
