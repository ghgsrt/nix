{ config, pkgs, inputs, dotfiles, lib,... }: {
  programs = {
    bash = {
        enable = true;
        bashrcExtra = builtins.readFile "${dotfiles}/.bashrc";
        profileExtra = builtins.readFile "${dotfiles}/.bash_profile";
      };

      zsh = {
        enable = true;

        oh-my-zsh.enable = true;

        plugins = [
          {
            name = "zsh-vi-mode";
            src = pkgs.fetchFromGitHub {
              owner = "jeffreytse";
              repo = "zsh-vi-mode";
              rev = "v0.11.0";
              sha256 = "sha256-xbchXJTFWeABTwq6h4KWLh+EvydDrDzcY9AQVK65RS8=";
            };
          }
          {
            name = "zsh-autosuggestions";
            src = pkgs.fetchFromGitHub {
              owner = "zsh-users";
              repo = "zsh-autosuggestions";
              rev = "v0.7.0";
              sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
            };
          }
          {
            name = "zsh-256color";
            src = pkgs.fetchFromGitHub {
              owner = "chrissicool";
              repo = "zsh-256color";
              rev = "9d8fa1015dfa895f2258c2efc668bc7012f06da6";
              sha256 = "sha256-Qd9pjDSQk+kz++/UjGVbM4AhAklc1xSTimLQXxN57pI=";
            };
          }
          {
            name = "zsh-syntax-highlighting";
            src = pkgs.fetchFromGitHub {
              owner = "zsh-users";
              repo = "zsh-syntax-highlighting";
              rev = "0.7.0";
              sha256 = "sha256-eRTk0o35QbPB9kOIV0iDwd0j5P/yewFFISVS/iEfP2g=";
            };
          }
          {
            name = "agnoster-nanof";
            file = "agnoster-nanof.zsh-theme";
            src = pkgs.fetchFromGitHub {
              owner = "fsegouin";
              repo = "oh-my-zsh-agnoster-mod-theme";
              rev = "46832da7156a4cd67e9b7ed245bb2782c690b8bb";
              sha256 = "sha256-hCG/N0AbjAxDLbMo+lLpf6SKyx5Athru84nWL/3spb4=";
            };
          }
        ];
    };
  };
}
