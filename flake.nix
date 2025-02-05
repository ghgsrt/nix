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

    dotfiles = {
      url = "github:ghgsrt/dotfiles";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # Helper to create system configurations
      mkSystem = { hostName, extraModules ? [] }: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/base.nix
#          ./hosts/${hostName}.nix
          home-manager.nixosModules.home-manager
          {
            networking.hostName = hostName;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ] ++ extraModules;
        specialArgs = { 
		inherit inputs; 
	        inherit (inputs) dotfiles;
	};
      };

      # Helper to create home configurations
      mkHome = { homeName ? "primary" }: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/base.nix
          ./home/${homeName}.nix
          {
            home = {
              #inherit username;
              homeDirectory = "/home/shared";
              stateVersion = "23.11";
            };
          }
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    in {
      nixosConfigurations = {
        wsl = mkSystem {
          hostName = "wsl";
          extraModules = [
            nixos-wsl.nixosModules.wsl
            {
              wsl.enable = true;
            }
          ];
        };
        thinkpad = mkSystem {
          hostName = "thinkpad";
        };
        # Add other hosts here
      };

      homeConfigurations = {
        "primary" = mkHome {
          #username = "bosco";
        };
        # Add other home configurations here
      };
    };
}
