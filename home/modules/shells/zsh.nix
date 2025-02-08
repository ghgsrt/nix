{ config, pkgs, inputs, dotfiles, lib,... }: 
let
  zshPackages = import ../../../packages/zsh.nix { inherit pkgs; };
in {
  home.packages = with zshPackages; [
	antigen
  ];

  programs = {
    bash = {
        enable = true;
#        bashrcExtra = builtins.readFile "${dotfiles}/.bashrc";
 #       profileExtra = builtins.readFile "${dotfiles}/.bash_profile";
      };

      zsh = {
        enable = true;
		initExtra = ''
		  export SHARE="$HOME/.nix-profile/share"
		'';

        # oh-my-zsh.enable = true;
        # enableCompletion = true;
        # enableAutosuggestions = true;
        # enableSyntaxHighlighting = true;

        # plugins = [
        #   {
        #     name = "zsh-vi-mode";
        #     src = pkgs.fetchFromGitHub {
        #       owner = "jeffreytse";
        #       repo = "zsh-vi-mode";
        #       rev = "v0.11.0";
        #       sha256 = "sha256-xbchXJTFWeABTwq6h4KWLh+EvydDrDzcY9AQVK65RS8=";
        #     };
        #   }
        #   {
        #     name = "zsh-256color";
        #     src = pkgs.fetchFromGitHub {
        #       owner = "chrissicool";
        #       repo = "zsh-256color";
        #       rev = "9d8fa1015dfa895f2258c2efc668bc7012f06da6";
        #       sha256 = "sha256-Qd9pjDSQk+kz++/UjGVbM4AhAklc1xSTimLQXxN57pI=";
        #     };
        #   }
          
        # ];
    };
  };
}
