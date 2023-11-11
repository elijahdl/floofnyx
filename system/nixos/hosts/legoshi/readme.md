# legoshi

## Overview

This is an AMD 7040 Framework 13
It is set up for opt-in-state

## Machine setup

```bash

```

Once the disk has been setup this flake can then be cloned and used.

```bash
# Clone and cd into nyx repo
nix-shell -p git --run "git clone https://github.com/elijahdl/floofnyx" && cd floofnyx

# Write a temp nix config file to enable flake support and extra binary caches
cat nix/nix.conf > ~/.config/nix/nix.conf

# Shell with flake support
nix-shell -p nixUnstable

# Edit flake.nix file to comment out internal.hostConfigurations.legoshi

# Install nixos with flake
sudo nixos-install --root /mnt --flake .#legoshi
```

### Note on nixos-install

There is currently some issues with `nixos-install` and a dependency in `home-manager`.
There is an error saying that accessing `nmd` in the `/nix/store` is forbidden.

See [discourse] discussion and nix [issue-4081] and nixpkgs [issue-126141].

My current workaround is to comment out `internal.hostConfigurations.legoshi` before the
`nixos-install` command.

There is another option currently of using `nix build` before nixos install. This is something that
I have not tested yet but it is another idea.

```bash
nix build .#top.legoshi && sudo nixos-install --root /mnt --system ./result
```

[discourse]: https://discourse.nixos.org/t/how-to-get-nixos-install-flake-to-work/10069
[issue-4081]: https://github.com/NixOS/nix/issues/4081
[issue-126141]: https://github.com/NixOS/nixpkgs/issues/126141

