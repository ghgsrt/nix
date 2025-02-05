{ config, lib, pkgs, ... }:

let
  inherit (import ../lib { inherit lib; }) mkComposableModule;
in
mkComposableModule {
  name = "tmux";

  packages = with pkgs; [
    tmux
    tpm
  ];

  extraConfig = {
    programs.tmux = {
      enable = true;
    };
  };
}