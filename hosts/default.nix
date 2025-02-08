{ config, lib, pkgs, inputs, ... }:
let
	inherit (import ../lib/default.nix) mkXdgMappings;
in
{
	# imports = [
	# 	../modules/desktop/sway.nix
	# ];

  time.timeZone = "America/New_York";

  networking = {
#    hostName = "base";
    enableIPv6 = true;
    #extraHosts = builtins.readFile "${inputs.hosts}/hosts";
    #dhcpcd.enable = true;
    networkmanager.enable = true;
    resolvconf.enable = true;
    nameservers = ["8.8.8.8"];
    firewall = {
      enable = true;
      allowedTCPPorts = [80 22 9090];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true; #use same kb settings (layout) as xorg

  users.mutableUsers = false;

   users.users = {
     "root" = {
	password = "root";
     };

     "bosco" = {
       isNormalUser = true;
       extraGroups = ["wheel" "audio" "video" "netdev" "lp" "input"]; # Enable ‘sudo’ for the user.
       password = "";
     };
   };

   security.sudo.extraRules = [{
    groups = [ "wheel" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

  environment.variables = {
    TERMINAL = "st";
    EDITOR = "nvim";
    VISUAL = "nvim";

    XKB_DEFAULT_LAYOUT = "us";

    NIXPKGS_ALLOW_UNFREE = "1";
  };

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    XDG_STATE_HOME = "\${HOME}/.local/state";
    XDG_DESKTOP_DIR = "\${HOME}/";
  };

  environment.localBinInPath = true;

  environment.systemPackages = with pkgs; [
    home-manager

    tmux
    git

    neovim

    ripgrep
    coreutils
    moreutils
    usbutils
    pciutils

    zip
    unzip
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  services = {
    openssh.enable = true;
    dbus.enable = true;
	kmscon = {
		enable = true;
		hwRender = true;
	};
  };

  security.polkit.enable = true;

    # Needed for nix-* commands to use the system's nixpkgs
  environment.etc."channels/nixpkgs".source = inputs.nixpkgs.outPath;

  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = ["nixpkgs=/etc/channels/nixpkgs" "nixos-config=/etc/nixos/configuration.nix" "/nix/var/nix/profiles/per-user/root/channels"];
    gc = {
      automatic = true;
      dates = "daily";
      options = "-d";
    };
    package = pkgs.nixVersions.stable;
    settings = {
      experimental-features = ["nix-command" "flakes" "ca-derivations" "auto-allocate-uids"];
      auto-optimise-store = true;
      auto-allocate-uids = true;
      max-jobs = "auto";
      cores = 0;
    };
  };

  hardware.enableRedistributableFirmware = true;
}
