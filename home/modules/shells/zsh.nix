{ config, pkgs, inputs, lib,... }:
let
  zshPackages = import ../../../packages/zsh.nix { inherit pkgs; };
in {
  home.packages = with zshPackages; [
	antigen
  ];

  programs.bash.enable = true;
  zsh.enable = true;
}
