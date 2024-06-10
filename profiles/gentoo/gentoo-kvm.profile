#!/usr/bin/env bash

part vda 1 83 256M
part vda 3 83 +

format /dev/vda1 ext2
format /dev/vda3 ext4

mountfs /dev/vda1 ext2 /boot
mountfs /dev/vda3 ext4 / noatime

stage_latest amd64 openrc
tree_type   snapshot    http://distfiles.gentoo.org/snapshots/portage-latest.tar.bz2

kernel_sources	         gentoo-kernel-bin
kernel_builder           binary

grub_install /dev/vda

timezone                UTC
rootpw                  a
bootloader              grub
keymap	                us
hostname                gentookvm
extra_packages          dhcpcd
