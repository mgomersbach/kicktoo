#!/usr/bin/env bash

gptspart vda 1 ef02 2048 4095
gptspart vda 2 ef00 4096 413695
gptspart vda 3 fd00 413696 +

format /dev/vda1 fat32
format /dev/vda2 fat32
format /dev/vda3 ext4

mountfs /dev/vda3 ext4 / noatime
mountfs /dev/vda2 vfat /boot
mountfs /dev/vda1 vfat /boot/efi

stage_latest amd64 openrc
tree_type   snapshot    http://distfiles.gentoo.org/snapshots/portage-latest.tar.bz2

makeconf_line            FEATURES="getbinpkg"
kernel_sources	         gentoo-kernel-bin

grub_install /dev/vda

timezone                UTC
rootpw                  a
bootloader              grub
keymap	                us
hostname                gentookvm
extra_packages          dhcpcd
