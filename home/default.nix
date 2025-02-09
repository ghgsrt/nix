{config, lib, ...}:
{
 xdg.userDirs.desktop = "$HOME/";

  # home.activation = {
  #   dotfilesInit = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #     ${dotfiles/init.sh}
  #   '';
  # };

  home.sessionVariables = {
    HOME_TYPE = "nix";
    HOME_NAME = lib.mkDefault "base";
  };

  fonts.fontconfig.enable = true;
  xdg.dataFile = {
    "fonts/custom" = {
      source = /config/dotfiles/fonts;
      recursive = true;
    };
  };

  services = {
    kmscon = {
      enable = true;
      hwRender = true;
    };
  };
}
