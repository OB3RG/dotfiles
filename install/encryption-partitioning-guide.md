# LVM Encryption Partitioning Guide

## Overview
This guide provides the partitioning commands needed for setting up LVM encryption on Arch Linux following the approach from https://tomaskala.com/posts/arch-linux-with-lvm-on-luks/

## Partitioning Steps

### 1. Partition the Disk
```bash
sgdisk --zap-all /dev/nvme0n1
sgdisk --new=1:0:+600M --typecode=1:ef00 /dev/nvme0n1   # EFI partition
sgdisk --new=2:0:+1G --typecode=2:8300 /dev/nvme0n1     # Boot partition
sgdisk --new=3:0:0 --typecode=3:8309 /dev/nvme0n1       # LUKS partition
```

### 2. Format Filesystems
```bash
mkfs.fat -F32 /dev/nvme0n1p1
mkfs.fat -F32 /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3
```

### 3. Encrypt the Main Partition
```bash
cryptsetup luksFormat /dev/nvme0n1p3
cryptsetup open /dev/nvme0n1p3 cryptlvm
```

### 4. Setup LVM
```bash
pvcreate /dev/mapper/cryptlvm
vgcreate vg0 /dev/mapper/cryptlvm
lvcreate -l 100%FREE vg0 -n root
```

### 5. Format LVM Volumes
```bash
mkfs.ext4 /dev/mapper/vg0-root
```

### 6. Mount Filesystems
```bash
mount /dev/mapper/vg0-root /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot
mount --mkdir /dev/nvme0n1p2 /mnt/boot/efi
```

### 7. Generate fstab
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

## Notes
- Adjust partition sizes as needed
- This guide should be followed before running the encryption-enabled installation script
- The boot partition is not encrypted for performance and compatibility reasons
- The EFI partition is also not encrypted as required by UEFI specification
