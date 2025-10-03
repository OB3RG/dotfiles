# LVM Encryption Partitioning Guide

## Overview
This guide provides the partitioning commands needed for setting up LVM encryption on Arch Linux.

## Partitioning Steps

### 1. Partition the Disk
Replace `/dev/sda` with your actual disk device (e.g., `/dev/nvme0n1`):
```bash
sgdisk --zap-all /dev/sda
sgdisk --new=1:0:+512M --typecode=1:ef00 /dev/sda  # EFI partition
sgdisk --new=2:0:0 --typecode=2:8309 /dev/sda      # LUKS partition
```

### 2. Encrypt the Main Partition
Replace `/dev/sda` with your actual disk device:
```bash
cryptsetup luksFormat --pbkdf pbkdf2 /dev/sda2
cryptsetup open /dev/sda2 cryptlvm
```

### 3. Setup LVM
```bash
pvcreate /dev/mapper/cryptlvm
vgcreate vg0 /dev/mapper/cryptlvm
lvcreate -l 100%FREE -n root vg0
```

### 4. Format Filesystems
Replace `/dev/sda` with your actual disk device:
```bash
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/vg0/root
```

### 5. Mount Filesystems
Replace `/dev/sda` with your actual disk device:
```bash
mount /dev/vg0/root /mnt
mount --mkdir /dev/sda1 /mnt/boot
```

## Notes
- Replace /dev/sda with your actual disk (e.g., /dev/nvme0n1)
- Adjust partition sizes as needed
- This guide should be followed before running the encryption-enabled installation script
