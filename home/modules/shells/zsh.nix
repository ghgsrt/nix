{ config, pkgs, inputs, lib,... }:
let
  zshPackages = import ../../../packages/zsh.nix { inherit pkgs; };
in {
  home.packages = with zshPackages; [
	antigen
  ];

  programs.zsh.enable = true;
}
