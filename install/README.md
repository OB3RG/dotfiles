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
| `aur.sh` | user | after first boot | Installs `paru` + `greetd-tuigreet`, enables greetd |

## Fresh install

From the booted Arch ISO:

```bash
# 1. (optional) load your keymap, then refresh mirrors
pacman -Syy

# 2. Partition, format, mount  — see partitioning-guide.md

# 3. Install the base system (use amd-ucode instead of intel-ucode on AMD)
pacstrap -K /mnt base linux linux-firmware git vim intel-ucode

# 4. Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

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
# SSH agent via gnome-keyring
systemctl --user enable gcr-ssh-agent.socket
systemctl --user enable ssh-agent.service
```
