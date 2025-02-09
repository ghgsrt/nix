{
  description = "NixOS and Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl/main";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    # dotfiles = {
    #   url = "github:ghgsrt/dotfiles";
    #   flake = false;
    # };
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      homes = [
        "base"
        "primary"
      ];

      users = {
        root = { defaultHome = "primary"; };
        bosco = { defaultHome = "primary"; };
      };

      # Generate all possible home configurations
      homeConfigurations = builtins.listToAttrs (
        builtins.concatMap
          (username: map
            (homeName: {
              name = "${homeName}-${username}";
              value = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                  ./home
                  ./home/${homeName}.nix
                  {
                    home = {
                      inherit username;
                      homeDirectory = "/home/${username}";
                      stateVersion = "23.11";
                    };
                  }
                ];
                extraSpecialArgs = { inherit inputs; };
              };
            })
            homes)
          (builtins.attrNames users)
      );

      # Helper to create system configurations
      mkSystem = { hostName, extraModules ? [], isVM ? false }: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = (if isVM then
            [./hosts/vm.nix]
          else
            [./hosts/base.nix]) ++ [
          home-manager.nixosModules.home-manager
          {
            networking.hostName = hostName;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = nixpkgs.lib.mapAttrs (username: userConfig: 
                (homeConfigurations."${userConfig.defaultHome}-${username}").config
              ) users;
            };
          }
        ] ++ extraModules;
        specialArgs = {
          inherit inputs;
        };
      };
    in {
      inherit homeConfigurations;

      nixosConfigurations = {
        wsl = mkSystem {
          hostName = "wsl";
          extraModules = [
            nixos-wsl.nixosModules.wsl
            { wsl.enable = true; }
          ];
        };
        vm = mkSystem {
          hostName = "vm";
          isVM = true;
        };
        thinkpad = mkSystem { hostName = "thinkpad"; };
      };
    };
}
