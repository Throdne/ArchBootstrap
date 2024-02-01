#!/bin/sh

# Script to install Arch Linux on a VPS with out the option to boot via an ISO.
# Download public key
mkdir -p /root/.ssh
wget https://raw.githubusercontent.com/Throdne/ArchBootstrap/main/id_ed25519.pub -O /root/.ssh/authorized_keys
systemctl restart sshd

# Download the Bootstrap file
cd /tmp
wget https://geo.mirror.pkgbuild.com/iso/latest/archlinux-bootstrap-x86_64.tar.gz
tar xzf /tmp/archlinux-bootstrap-x86_64.tar.gz --numeric-owner

# Sets the mirror for pacman 
sed -i 's|#Server = https://geo.mirror.pkgbuild.com/\$repo/os/\$arch|Server = https://geo.mirror.pkgbuild.com/\$repo/os/\$arch|' /tmp/root.x86_64/etc/pacman.d/mirrorlist

# Going int Arch Linux to complete the install
/tmp/root.x86_64/bin/arch-chroot /tmp/root.x86_64/

# rebuilds pacman
pacman-key --init
pacman-key --populate