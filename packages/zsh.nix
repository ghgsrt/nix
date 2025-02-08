{ pkgs ? import <nixpkgs> {} }:
{
  antigen = pkgs.stdenv.mkDerivation {
    name = "zsh-antigen";
    version = "1.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "zsh-users";
      repo = "antigen";
      rev = "v2.2.3";
      sha256 = "1av6vn1q8c49sqcam59ymsd5g7hw1vyk365iyrz76m5i3hik0n45";  # Replace with correct hash
    };

    installPhase = ''
      mkdir -p $out/share/zsh/plugins/zsh-antigen
      cp antigen.zsh $out/share/zsh/plugins/zsh-antigen/
    '';
  };
}
