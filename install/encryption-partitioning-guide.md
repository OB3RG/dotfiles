# LVM Encryption Partitioning Guide

## Overview
This guide provides the partitioning commands needed for setting up LVM encryption on Arch Linux.

## Partitioning Steps

### 1. Partition the Disk
Assuming /dev/sda as the target disk:
```bash
sgdisk --zap-all /dev/sda
sgdisk --new=1:0:+512M --typecode=1:ef00 /dev/sda  # EFI partition
sgdisk --new=2:0:0 --typecode=2:8309 /dev/sda      # LUKS partition
```

### 2. Encrypt the Main Partition
```bash
cryptsetup luksFormat --pbkdf pbkdf2 /dev/sda2
cryptsetup open /dev/sda2 cryptlvm
```

### 3. Setup LVM
```bash
pvcreate /dev/mapper/cryptlvm
vgcreate MainGroup /dev/mapper/cryptlvm
lvcreate -l 100%FREE -n root MainGroup
```

### 4. Format Filesystems
```bash
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/MainGroup/root
```

### 5. Mount Filesystems
```bash
mount /dev/MainGroup/root /mnt
mount --mkdir /dev/sda1 /mnt/boot
```

## Notes
- Replace /dev/sda with your actual disk
- Adjust partition sizes as needed
- This guide should be followed before running the encryption-enabled installation script
