#!/bin/bash

echo "Starting Arch Linux installation..."

# Script to install Arch Linux on a VPS with out the option to boot via an ISO.
# Download public key
echo "Downloading public key..."
mkdir -p /root/.ssh
wget https://raw.githubusercontent.com/Throdne/ArchBootstrap/main/id_ed25519.pub -O /root/.ssh/authorized_keys
systemctl restart sshd

# Download the Bootstrap file
echo "Downloading the Bootstrap file..."
cd /tmp
wget https://geo.mirror.pkgbuild.com/iso/latest/archlinux-bootstrap-x86_64.tar.gz
tar xzf /tmp/archlinux-bootstrap-x86_64.tar.gz --numeric-owner

# Sets the mirror for pacman 
echo "Setting the mirror for pacman..."
sed -i 's|#Server = https://geo.mirror.pkgbuild.com/\$repo/os/\$arch|Server = https://geo.mirror.pkgbuild.com/\$repo/os/\$arch|' /tmp/root.x86_64/etc/pacman.d/mirrorlist

# download chroo.sh
echo "Downloading chroot.sh..."
wget https://raw.githubusercontent.com/Throdne/ArchBootstrap/main/chroot.sh -O /tmp/root.x86_64/root/chroot.sh
chmod +x /tmp/root.x86_64/root/chroot.sh

# Going int Arch Linux to complete the install
echo "chroot into Arch..."
/tmp/root.x86_64/bin/arch-chroot /tmp/root.x86_64/ /root/chroot.sh

echo "Arch Linux installation completed."