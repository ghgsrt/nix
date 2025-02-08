{config, ...}:
let
  dotfiles = builtins.getEnv "DOTFILES_DIR";
in {
 xdg.userDirs.desktop = "$HOME/";

  home.activation = {
    dotfilesInit = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${dotfiles/init.sh}
    '';
  };

  home.sessionVariables = {
    HOME_TYPE = "nix";
    HOME_NAME = "base";
  };

  fonts.fontconfig.enable = true;
  xdg.dataFile = {
    "fonts/custom" = {
      source = "${dotfiles}/fonts/";
      recursive = true;
    };
  };
}
