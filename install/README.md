# Arch Linux Install

Bootstrap a fresh machine from the Arch ISO to a working **GNOME** desktop
(vanilla upstream, Fedora-style curated package set, GDM login manager).

There is **one** package set for every machine (`packages.sh`). The only
per-machine difference is the GPU driver: the NVIDIA laptop additionally runs
`gpu-nvidia.sh`; AMD/Intel machines need nothing extra.

## Scripts

| Script | Run as | When | Does |
|---|---|---|---|
| `bootstrap.sh` | root, in chroot | install | Base system: locale, users, GRUB, networking, then `packages.sh` |
| `packages.sh` | root | install / anytime | All packages: GNOME desktop + GDM, dev tools, apps |
| `gpu-nvidia.sh` | root | laptop only | NVIDIA drivers + `tlp` |
| `theme-tokyonight.sh` | user | after first boot | Tokyo Night GTK theme from GitHub (incl. GTK4/libadwaita links) — no AUR |
| `gnome-settings.sh` | user | after first boot | Dark mode, Tokyo Night gtk-theme, ghostty as default terminal |

## Fresh install

From the booted Arch ISO:

```bash
# 1. (optional) load your keymap, then refresh mirrors
pacman -Syy

# 2. Partition, format, mount  — see partitioning-guide.md
#    BTRFS is recommended (enables Timeshift snapshots)

# 3. Install the base system (use amd-ucode instead of intel-ucode on AMD)
pacstrap -K /mnt base linux linux-firmware git vim intel-ucode

# 4. Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# 4b. BTRFS only: verify fstab has all subvolume mounts
#     See partitioning-guide.md for the expected fstab layout

# 5. Enter the new system
arch-chroot /mnt

# 6. Grab this repo and run the bootstrap
git clone https://github.com/OB3RG/dotfiles /root/dotfiles
cd /root/dotfiles/install
chmod +x *.sh
./bootstrap.sh            # sets passwords for oberg + root, installs everything

# 7. Laptop only: NVIDIA drivers
./gpu-nvidia.sh

# 8. Leave and reboot
exit
umount -R /mnt
reboot
```

## After first boot

GDM starts automatically. Log in as `oberg`, then set up dotfiles and theming:

```bash
# 1. Clone the repo to its home and stow all configs
git clone https://github.com/OB3RG/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh

# 2. Install the Tokyo Night GTK theme (straight from GitHub, no AUR)
./install/theme-tokyonight.sh

# 3. Apply GNOME settings (dark mode, Tokyo Night, ghostty as terminal)
./install/gnome-settings.sh

# 4. Re-login (or reboot) so the theme is picked up everywhere
reboot
```

Machine-specific tweaks (monitor layout, scaling, night light) live in
**GNOME Settings > Displays** — they are stored per-machine in
`~/.config/monitors.xml` and intentionally not stowed.

## Post-install extras

```bash
# SSH agent via gnome-keyring/gcr — already enabled by install.sh
# After first login, add your key once:
#   ssh-add ~/.ssh/id_rsa
# The keyring unlocks at GDM login and caches the passphrase until reboot.

# Tokyo Night variants (Storm/Moon color schemes, accent colors, compact) can
# be installed by re-running the theme installer with different flags, e.g.:
#   ~/.local/src/Tokyonight-GTK-Theme/themes/install.sh --color Dark --tweaks storm
# Then pick it via gnome-tweaks or:
#   gsettings set org.gnome.desktop.interface gtk-theme 'Tokyonight-Storm-Dark'

# Screenshots: built into GNOME — press PrtSc for the interactive UI,
# or Alt+PrtSc (window) / Shift+PrtSc (area) for direct captures.

# UFW: add any extra rules you need (SSH is already allowed)
# ufw allow 8080/tcp
```

## Timeshift notes

Timeshift is installed and ready.

### BTRFS (recommended)

If you followed the BTRFS partitioning guide, Timeshift works out of the box.
The `@` root subvolume and `@snapshots` subvolume are already created.

Create your first snapshot:
```bash
sudo timeshift --create --comments "Fresh install"
```

Set up automatic snapshots (e.g., daily + weekly):
```bash
sudo timeshift --setup-schedule --freq daily --count 7
```

Or use the GUI: `sudo timeshift-gtk`

### ext4

Uses rsync mode. Requires `rsync` and `cronie` (both installed by `bootstrap.sh`).
Configure via the GUI: `sudo timeshift-gtk`
