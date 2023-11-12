#!/bin/sh

nixos-generate-config --root /mnt

cp /mnt/etc/nixos/hardware-configuration.nix system/nixos/hosts/legoshi/hardware.nix 

patch -p1  < 02a_hardware.patch