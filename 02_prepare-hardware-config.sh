#!/bin/sh

sudo nixos-generate-config --root /mnt

cp /mnt/etc/nixos/hardware-configuration.nix system/nixos/hosts/legoshi/hardware.nix 

patch system/nixos/hosts/legoshi/hardware.nix 02a_hardware.patch

mkdir ~/.config/nix

cp nix/nix.conf ~/.config/nix/

nix-shell -p nixUnstable