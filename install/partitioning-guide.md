# Partitioning Guide

Partitioning commands for a standard (unencrypted) UEFI Arch install.

## 1. Partition the disk

Assuming `/dev/sda` as the target disk:

```bash
sgdisk --zap-all /dev/sda
sgdisk --new=1:0:+512M --typecode=1:ef00 /dev/sda  # EFI system partition
sgdisk --new=2:0:0     --typecode=2:8300 /dev/sda  # root partition
```

## 2. Format

### BTRFS (recommended — enables Timeshift snapshots)

```bash
mkfs.fat -F32 /dev/sda1
mkfs.btrfs -L arch /dev/sda2
```

### ext4 (simpler, no snapshot support)

```bash
mkfs.fat -F32 /dev/sda1
mkfs.ext4 -L arch /dev/sda2
```

## 3. Mount

### BTRFS (with subvolumes for Timeshift)

```bash
# Mount the BTRFS filesystem temporarily to create subvolumes
mount /dev/sda2 /mnt

# Create Timeshift-compatible subvolumes
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@snapshots

# Unmount and remount with subvolumes
umount /mnt
mount -o subvol=@,compress=zstd /dev/sda2 /mnt
mount --mkdir -o subvol=@home,compress=zstd /dev/sda2 /mnt/home
mount --mkdir -o subvol=@log,compress=zstd,noatime /dev/sda2 /mnt/var/log
mount --mkdir -o subvol=@cache,compress=zstd,noatime /dev/sda2 /mnt/var/cache
mount --mkdir -o subvol=@tmp,compress=zstd,noatime /dev/sda2 /mnt/var/tmp
mount --mkdir -o subvol=@snapshots,compress=zstd /dev/sda2 /mnt/.snapshots

# Mount EFI
mount --mkdir /dev/sda1 /mnt/boot
```

### ext4

```bash
mount /dev/sda2 /mnt
mount --mkdir /dev/sda1 /mnt/boot
```

## 4. Install the base system

```bash
# Use amd-ucode instead of intel-ucode on AMD
pacstrap -K /mnt base linux linux-firmware git vim intel-ucode
genfstab -U /mnt >> /mnt/etc/fstab
```

### BTRFS: fix fstab after genfstab

`genfstab` may not include all subvolume mount options. Verify `/mnt/etc/fstab` has:

```
# <device>  <dir>        <type>  <options>                  <dump> <pass>
/dev/sda2   /            btrfs   subvol=@,compress=zstd     0      0
/dev/sda2   /home        btrfs   subvol=@home,compress=zstd 0      0
/dev/sda2   /var/log     btrfs   subvol=@log,compress=zstd,noatime 0 0
/dev/sda2   /var/cache   btrfs   subvol=@cache,compress=zstd,noatime 0 0
/dev/sda2   /var/tmp     btrfs   subvol=@tmp,compress=zstd,noatime 0 0
/dev/sda2   /.snapshots  btrfs   subvol=@snapshots,compress=zstd 0 0
/dev/sda1   /boot        vfat    defaults                   0      2
```

If any subvolume mount is missing, add it manually before running `bootstrap.sh`.

## Notes

- Replace `/dev/sda` with your actual disk (`lsblk` to check).
- Do this before running `bootstrap.sh` (see [README.md](README.md)).
- **BTRFS + Timeshift**: The `@` and `@snapshots` subvolume names are required for Timeshift BTRFS mode to work.
- **Compression**: `compress=zstd` is enabled on all subvolumes — transparent compression with minimal CPU overhead.
- **noatime**: Applied to log/cache/tmp subvolumes to reduce write amplification.
