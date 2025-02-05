{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  imports = [
    ./default.nix
    <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>
  ];
  virtualisation.qemu.options = [
    "-device virtio-vga"
  ];
}