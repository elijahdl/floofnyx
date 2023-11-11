{ pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Hardware ------------------------------------------------------------------

  boot = {
    kernelModules = [ "kvm-amd" ];
    initrd = {
      # availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "firewire_ohci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" ];
      kernelModules = [ ];
    };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

    fileSystems."/" =
    { device = "/dev/disk/by-uuid/7a60625a-f54b-4ba2-bb0c-783465f7c65f";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  boot.initrd.luks.devices."terra-crypt".device = "/dev/disk/by-uuid/abeb2489-cbe6-4be7-8dae-32e573dd479b";

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/7a60625a-f54b-4ba2-bb0c-783465f7c65f";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/7a60625a-f54b-4ba2-bb0c-783465f7c65f";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/7a60625a-f54b-4ba2-bb0c-783465f7c65f";
      fsType = "btrfs";
      options = [ "subvol=persist" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/7a60625a-f54b-4ba2-bb0c-783465f7c65f";
      fsType = "btrfs";
      options = [ "subvol=log" ];
    };

  fileSystems."/swap" =
    { device = "/dev/disk/by-uuid/7a60625a-f54b-4ba2-bb0c-783465f7c65f";
      fsType = "btrfs";
      options = [ "subvol=swap" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1930-669A";
      fsType = "vfat";
    };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;



#  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  # ---------------------------------------------------------------------------
}
