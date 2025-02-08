{ config, lib, pkgs, dotfiles, ... }: {
  imports = [
    #./modules/desktop/sway.nix
    ./modules/shells/zsh.nix 
    #./modules/shells/starship.nix (dotfiles)
  ];

  home.sessionVariables = {
    TERMINAL = "foot";
  };
}
