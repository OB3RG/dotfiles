#!/usr/bin/env bash

# Install large binaries using our custom scripts
# These binaries are no longer included in the repo to reduce size
echo "Installing large binaries..."
cd "$(dirname "$0")/scripts"
./install-kubectl.sh
./install-sops.sh
./install-talosctl.sh
