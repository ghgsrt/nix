{ config, lib, pkgs, ... }: {
  imports = [
    ./modules/desktop/sway.nix
    ./modules/shells/zsh.nix
  ];

  home.sessionVariables = {
    HOME_NAME = "primary";

    SHELL = lib.mkForce "zsh";
  };
}
