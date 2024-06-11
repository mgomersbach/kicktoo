#!/usr/bin/env bash

# efi
gptspart nvme0n1 1 ef02 2048 4095
# boot
gptspart nvme0n1 2 ef00 4096 413695
# 16gb swap
gptspart nvme0n1 3 8200 413696 33554431
# root
gptspart nvme0n1 4 fd00 33554432 +

format /dev/nvme0n1p1 fat32
format /dev/nvme0n1p2 fat32
format /dev/nvme0n1p3 swap
format /dev/nvme0n1p4 ext4

mountfs /dev/nvme0n1p4 ext4 / noatime
mountfs /dev/nvme0n1p3 swap
mountfs /dev/nvme0n1p2 vfat /boot
mountfs /dev/nvme0n1p1 vfat /boot/efi

stage_latest amd64 openrc
tree_type   snapshot    http://distfiles.gentoo.org/snapshots/portage-latest.tar.bz2

makeconf_line            FEATURES="getbinpkg parallel-fetch parallel-install"
kernel_sources	         gentoo-kernel-bin
skip                     install_kernel_builder
skip                     install_initramfs_builder
skip                     build_kernel

grub_install /dev/nvme0n1

timezone                UTC
rootpw                  a
bootloader              grub
keymap	                us
hostname                gentookvm
extra_packages          dhcpcd
