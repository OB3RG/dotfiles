# Arch Linux Install

Bootstrap a fresh machine from the Arch ISO to a working **Sway** desktop.

There is **one** package set for every machine (`packages.sh`). The only
per-machine difference is the GPU driver: the NVIDIA laptop additionally runs
`gpu-nvidia.sh`; AMD/Intel machines need nothing extra.

## Scripts

| Script | Run as | When | Does |
|---|---|---|---|
| `bootstrap.sh` | root, in chroot | install | Base system: locale, users, GRUB, networking, then `packages.sh` |
| `packages.sh` | root | install / anytime | All packages: Sway desktop, dev tools, apps, greetd |
| `gpu-nvidia.sh` | root | laptop only | NVIDIA drivers + `tlp` |
| `aur.sh` | user | after first boot | Installs `paru` + `greetd-tuigreet` + `gruvbox-dark-gtk`, enables greetd |

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

Log in on the TTY as `oberg`, then set up the dotfiles and greeter:

```bash
# 1. Clone the repo to its home and stow all configs
git clone https://github.com/OB3RG/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh

# 2. Install AUR bits (tuigreet) and enable the graphical login
./install/aur.sh

# 3. Reboot into tuigreet -> sway
reboot
```

Machine-specific tweaks (monitor layout, scaling) go in
`~/.config/sway/config.local` — see the main [readme](../readme.md).

## Post-install extras

```bash
# SSH agent via gnome-keyring/gcr — already enabled by install.sh
# After first login, add your key once:
#   ssh-add ~/.ssh/id_rsa
# The keyring unlocks at login and caches the passphrase until reboot.

# Papirus folders: set darkcyan folder color
papirus-folders -C darkcyan

# Apply Gruvbox GTK theme (after aur.sh installs it)
gsettings set org.gnome.desktop.interface gtk-theme 'gruvbox-dark-gtk'

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
