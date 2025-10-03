A small summary:

If needed, load your keymap

Refresh the servers with pacman -Syy

Partition the disk

For standard installation:
Format the partitions
mkfs.fat -F 32 /dev/_efi_system_partition_
mkfs.ext4 /dev/_root_partition_

Mount the partitions
mount /dev/_root_partition_ /mnt
mount --mkdir /dev/efi_system_partition /mnt/boot

For encrypted installation:
Follow the steps in encryption-partitioning-guide.md

Install the base packages into /mnt (pacstrap /mnt base linux linux-firmware git vim intel-ucode (or amd-ucode))

Generate the FSTAB file with genfstab -U /mnt >> /mnt/etc/fstab

Chroot in with arch-chroot /mnt

Download the git repository with git clone https://github.com/ob3rg/dotfiles

cd install

For standard installation: chmod +x install-uefi.sh && ./install-uefi.sh
For encrypted installation: chmod +x install-enc-uefi.sh && ./install-enc-uefi.sh




## Post install

systemctl --user enable gcr-ssh-agent.socket
systemctl --user enable ssh-agent.service
