#!/usr/bin/env bash
# Install dev packages on Fedora (GNOME desktop is provided by the OS install).
# Run as the normal user; sudo is used where needed.
set -euo pipefail

# RPM Fusion (free + nonfree) — media codecs, Steam, etc. Idempotent.
sudo dnf install -y \
  "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
  "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

# Package groups (kept together for readability):
#   dotfiles   - stow manages the symlinks
#   dev        - editor, shell and tooling
#   nix        - the Nix package manager (nix-shell); daemon is socket-activated
#   utils      - clipboard (Wayland), system monitoring
sudo dnf install -y \
  stow git \
  zsh fzf ripgrep tmux neovim tree-sitter-cli \
  golang podman gh \
  nix \
  wl-clipboard btop fastfetch

# SELinux: Fedora's policy has no file contexts for /nix, so the tree is
# labeled default_t. Map it to var_t and relabel. Idempotent.
if ! sudo semanage fcontext -l | grep -q '^/nix('; then
  sudo semanage fcontext -a -t var_t '/nix(/.*)?'
fi
sudo restorecon -Rv /nix

# Nix multi-user daemon. Use the service, NOT nix-daemon.socket: pid 1 is
# denied creating sock_files under /nix whatever the label (no usable type
# exists in the policy), so socket activation can't work under SELinux.
# The daemon creates the socket itself, so run it as unconfined_service_t
# via a drop-in; SELinux stays enforcing for everything else.
sudo mkdir -p /etc/systemd/system/nix-daemon.service.d
sudo tee /etc/systemd/system/nix-daemon.service.d/10-unconfined.conf >/dev/null <<'EOF'
# Fedora's SELinux policy has no nix domain; run the daemon unconfined so it
# can create /nix/var/nix/daemon-socket/socket and manage the store.
[Service]
SELinuxContext=system_u:system_r:unconfined_service_t:s0
EOF
sudo systemctl daemon-reload
sudo systemctl disable --now nix-daemon.socket 2>/dev/null || true
sudo systemctl enable --now nix-daemon.service

# Optional: kubectl (Fedora ships versioned client packages)
# sudo dnf install -y kubernetes1.35-client
# or get the latest upstream binary: ~/.local/bin/install-kubectl.sh

# sops is not packaged for Fedora — install it to ~/.local/bin:
#   ~/.local/bin/install-sops.sh

echo "Packages installed."
echo "Log out and back in for the nix profile to land in PATH."
