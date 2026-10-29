# Partitioning Guide

Partitioning commands for a UEFI Arch install. Two layouts are supported:

- **Plain** (unencrypted) — personal machines
- **LUKS** (full-disk encryption) — work machine

Both use the same EFI partition and the same BTRFS subvolume layout; the only
difference is whether the root filesystem lives directly on the partition or
inside a LUKS container. `bootstrap.sh` detects an unlocked LUKS root
automatically and configures mkinitcpio + GRUB accordingly.

Examples use `/dev/nvme0n1` — check with `lsblk` and adjust
(`/dev/sda` on SATA disks; partitions are then `sda1`/`sda2`).

## 1. Partition the disk

```bash
sgdisk --zap-all /dev/nvme0n1
sgdisk --new=1:0:+512M --typecode=1:ef00 /dev/nvme0n1  # EFI system partition
sgdisk --new=2:0:0     --typecode=2:8309 /dev/nvme0n1  # root (8309 = LUKS hint; 8300 also fine)
```

## 2. (LUKS only) Create and open the encrypted container

Skip this step for a plain install.

```bash
cryptsetup luksFormat /dev/nvme0n1p2        # asks for the disk passphrase
cryptsetup open /dev/nvme0n1p2 cryptroot    # unlocks to /dev/mapper/cryptroot
```

From here on, use `/dev/mapper/cryptroot` wherever the plain layout uses
`/dev/nvme0n1p2`.

## 3. Format

### BTRFS (recommended — enables Timeshift snapshots)

```bash
mkfs.fat -F32 /dev/nvme0n1p1
mkfs.btrfs -L arch /dev/mapper/cryptroot    # or /dev/nvme0n1p2 for plain
```

### ext4 (simpler, Timeshift falls back to rsync mode)

```bash
mkfs.fat -F32 /dev/nvme0n1p1
mkfs.ext4 -L arch /dev/mapper/cryptroot     # or /dev/nvme0n1p2 for plain
```

## 4. Mount

### BTRFS (with subvolumes for Timeshift)

```bash
# Mount the BTRFS filesystem temporarily to create subvolumes
mount /dev/mapper/cryptroot /mnt

# Create Timeshift-compatible subvolumes
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@snapshots

# Unmount and remount with subvolumes
umount /mnt
mount -o subvol=@,compress=zstd /dev/mapper/cryptroot /mnt
mount --mkdir -o subvol=@home,compress=zstd /dev/mapper/cryptroot /mnt/home
mount --mkdir -o subvol=@log,compress=zstd,noatime /dev/mapper/cryptroot /mnt/var/log
mount --mkdir -o subvol=@cache,compress=zstd,noatime /dev/mapper/cryptroot /mnt/var/cache
mount --mkdir -o subvol=@tmp,compress=zstd,noatime /dev/mapper/cryptroot /mnt/var/tmp
mount --mkdir -o subvol=@snapshots,compress=zstd /dev/mapper/cryptroot /mnt/.snapshots

# Mount EFI (always the plain partition, never encrypted)
mount --mkdir /dev/nvme0n1p1 /mnt/boot
```

### ext4

```bash
mount /dev/mapper/cryptroot /mnt            # or /dev/nvme0n1p2 for plain
mount --mkdir /dev/nvme0n1p1 /mnt/boot
```

## 5. Install the base system

```bash
# Use amd-ucode instead of intel-ucode on AMD
pacstrap -K /mnt base linux linux-firmware git vim intel-ucode
genfstab -U /mnt >> /mnt/etc/fstab
```

### BTRFS: fix fstab after genfstab

`genfstab` may not include all subvolume mount options. Verify `/mnt/etc/fstab`
has entries like these (genfstab -U writes them as `UUID=...`; the device for
root is `/dev/mapper/cryptroot` on LUKS, `/dev/nvme0n1p2` on plain):

```
# <dir>        <options>
/              btrfs   subvol=@,compress=zstd
/home          btrfs   subvol=@home,compress=zstd
/var/log       btrfs   subvol=@log,compress=zstd,noatime
/var/cache     btrfs   subvol=@cache,compress=zstd,noatime
/var/tmp       btrfs   subvol=@tmp,compress=zstd,noatime
/.snapshots    btrfs   subvol=@snapshots,compress=zstd
/boot          vfat    defaults
```

If any subvolume mount is missing, add it manually before running `bootstrap.sh`.

## Notes

- Do this before running `bootstrap.sh` (see [README.md](README.md)).
- **LUKS**: no extra steps in `bootstrap.sh` — it detects the encrypted root,
  adds the `encrypt` mkinitcpio hook, regenerates the initramfs and sets the
  `cryptdevice=`/`root=` kernel parameters for GRUB. At every boot you'll be
  asked for the disk passphrase before GNOME starts.
- **EFI partition is never encrypted** — that's the standard trade-off of this
  layout (an attacker could tamper with the kernel/GRUB but not read your data).
- **BTRFS + Timeshift**: The `@` and `@snapshots` subvolume names are required
  for Timeshift BTRFS mode to work — with or without LUKS.
- **Compression**: `compress=zstd` is enabled on all subvolumes — transparent
  compression with minimal CPU overhead.
- **noatime**: Applied to log/cache/tmp subvolumes to reduce write amplification.
- **Swap**: no swap partition — `bootstrap.sh` sets up zram
  (compressed RAM swap, Fedora-style) via `zram-generator` on all machines.
