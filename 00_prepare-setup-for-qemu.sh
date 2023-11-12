#!/bin/sh

sed -i 's/nvme0n1p1/vda1/g' system/nixos/hosts/legoshi/setup.sh
sed -i 's/nvme0n1p2/vda2/g' system/nixos/hosts/legoshi/setup.sh
sed -i 's/nvme0n1/vda/g' system/nixos/hosts/legoshi/setup.sh
