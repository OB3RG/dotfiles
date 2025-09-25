# Standard Partitioning Guide

## Overview
This guide provides the partitioning commands needed for the standard Arch Linux installation.

## Partitioning Steps

### 1. Partition the Disk
Assuming /dev/sda as the target disk:
```bash
sgdisk --zap-all /dev/sda
sgdisk --new=1:0:+512M --typecode=1:ef00 /dev/sda  # EFI partition
sgdisk --new=2:0:0 --typecode=2:8300 /dev/sda      # Root partition
```

### 2. Format Filesystems
```bash
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
```

### 3. Mount Filesystems
```bash
mount /dev/sda2 /mnt
mount --mkdir /dev/sda1 /mnt/boot
```

## Notes
- Replace /dev/sda with your actual disk
- This guide should be followed before running the standard installation script (install-uefi.sh)
