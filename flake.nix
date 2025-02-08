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

  outputs = { self, nixpkgs, home-manager, nixos-wsl, dotfiles,... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # Helper to create system configurations
      mkSystem = { hostName, extraModules ? [], isVM ? false, defaultHome ? "primary" }: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = (if isVM then
            [./hosts/vm.nix]
          else
            [./hosts/base.nix]) ++ [
#          ./hosts/${hostName}.nix
          home-manager.nixosModules.home-manager
          {
            networking.hostName = hostName;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                ./home/${defaultHome}.nix
              ];
            };
          }
        ] ++ extraModules;
        specialArgs = {
		inherit inputs;
	        inherit (inputs) dotfiles;
	};
      };

      # Helper to create home configurations
      mkHome = { username, homeName ? "primary" }: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/base.nix
          ./home/${homeName}.nix
          {
            home = {
              username = username;
            # homeName = homeName;
              homeDirectory = "/home/${username}";
              stateVersion = "23.11";
            };
          }
        ];
        extraSpecialArgs = { 
		inherit inputs; 
		inherit (inputs) dotfiles;	
	};
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
        vm = mkSystem {
          hostName = "vm";
          isVM = true;
        };
        thinkpad = mkSystem {
          hostName = "thinkpad";
        };
        # Add other hosts here
      };

      homeConfigurations = {
        "primary" = mkHome {
          username = "bosco";
        };
        # Add other home configurations here
      };
    };
}
