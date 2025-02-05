{ lib, ... }:

with lib;

{
  # Helper function to create a composable home environment module
  mkComposableModule = {
    name,  # Will be used for both module namespace and program enabling
    packages ? [],
    variables ? {},
    imports ? [],
    systemdServices ? {},
    xdg ? {},
    systemPackages ? [],
    configFiles ? {},
    extraConfig ? {},
    programConfig ? {},  # Configuration specific to the program itself
  }:
    { config, lib, pkgs, ... }:

    let
      cfg = config.modules.${name};
    in {
      options.modules.${name} = {
        enable = mkEnableOption "${name}";
      };

      config = mkIf cfg.enable (mkMerge [
        {
          # Basic configuration
          home.packages = packages;
          home.sessionVariables = variables;
          imports = imports;

          # Automatically enable and configure the program if it exists
          programs.${name} = mkMerge [
            { enable = true; }
            programConfig
          ];

          # Systemd user services
          systemd.user.services = systemdServices;

          # XDG configuration
          xdg = xdg;

          # Custom configuration files
          home.file = configFiles;
        }
        # Merge in any extra configuration
        extraConfig
      ]);
    };
}