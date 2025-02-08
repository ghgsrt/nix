{ pkgs ? import <nixpkgs> {} }:
{
  antigen = pkgs.stdenv.mkDerivation {
    name = "zsh-antigen";
    version = "1.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "zsh-users";
      repo = "antigen";
      rev = "v2.2.3";
      sha256 = "0d7wp1l1dcr24qhw03dlkcpnd3r9kxxnqjs386jp876rbc05iskz";  # Replace with correct hash
    };

    installPhase = ''
      mkdir -p $out/share/zsh/plugins/zsh-antigen
      cp antigen.zsh $out/share/zsh/plugins/zsh-antigen/
    '';
  }
}