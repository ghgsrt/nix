{ config, pkgs, inputs }: {
  imports = [
    ./modules/desktop.nix
  ];

  modules = {
    desktop = {
      sway.enable = true;
    };
  };
}