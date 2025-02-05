{ config, lib, pkgs, inputs, dotfiles, ... }:

{
  imports = [
  ./default.nix
	/etc/nixos/hardware-configuration.nix
];

  boot = lib.mkDefault {
    loader = {
      efi = {
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "nodev";
        enableCryptodisk = true;
        useOSProber = true;
      };
      timeout = 5;
    };

    supportedFilesystems = ["ntfs"];
    tmp.useTmpfs = true;
  };
}
