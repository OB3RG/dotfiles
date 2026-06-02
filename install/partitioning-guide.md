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

```bash
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
```

## 3. Mount

```bash
mount /dev/sda2 /mnt
mount --mkdir /dev/sda1 /mnt/boot
```

## Notes

- Replace `/dev/sda` with your actual disk (`lsblk` to check).
- Do this before running `bootstrap.sh` (see [README.md](README.md)).
