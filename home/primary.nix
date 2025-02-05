{ config, lib, pkgs, ... }: {
  imports = [
    ./modules/desktop/sway.nix
    ./modules/shells/zsh.nix
  ];
}