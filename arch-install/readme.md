A small summary:

If needed, load your keymap
Refresh the servers with pacman -Syy
Partition the disk
Format the partitions
Mount the partitions
Install the base packages into /mnt (pacstrap /mnt base linux linux-firmware git vim intel-ucode (or amd-ucode))
Generate the FSTAB file with genfstab -U /mnt >> /mnt/etc/FSTAB
Chroot in with arch-chroot /mnt
Download the git repository with git clone https://gitlab.com/ob3rg/dotfiles

cd arch-install
chmod +x install-uefi.sh
run with ./install-uefi.sh
