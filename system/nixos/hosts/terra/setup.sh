#!/bin/sh

set -e

parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 1024MiB
parted /dev/nvme0n1 -- mkpart primary 1024MiB 100%
parted /dev/nvme0n1 -- set 1 esp on

mkfs.fat -F 32 -n boot /dev/nvme0n1p1

cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup open /dev/nvme0n1p2 terra-crypt

mkfs.btrfs -L terra-crypt -s 4k /dev/mapper/terra-crypt

mount -t btrfs /dev/mapper/terra-crypt /mnt

btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/persist
btrfs subvolume create /mnt/log

btrfs subvolume create /mnt/swap
btrfs filesystem mkswapfile --size 16g --uuid clear /mnt/swap/swapfile

btrfs subvolume snapshot -r /mnt/root /mnt/root-blank

umount /mnt

mount -o subvol=root,compress=zstd,noatime /dev/mapper/terra-crypt /mnt

mkdir /mnt/home
mount -o subvol=home,compress=zstd,noatime /dev/mapper/terra-crypt /mnt/home

mkdir /mnt/nix
mount -o subvol=nix,compress=zstd,noatime /dev/mapper/terra-crypt /mnt/nix

mkdir /mnt/persist
mount -o subvol=persist,compress=zstd,noatime /dev/mapper/terra-crypt /mnt/persist

mkdir -p /mnt/var/log
mount -o subvol=log,compress=zstd,noatime /dev/mapper/terra-crypt /mnt/var/log

mkdir /mnt/swap
mount -o subvol=swap,noatime /dev/mapper/terra-crypt /mnt/swap

mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot

swapon /mnt/swap/swapfile
