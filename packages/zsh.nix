{ pkgs ? import <nixpkgs> {} }:
{
  antigen = pkgs.stdenv.mkDerivation {
    name = "zsh-antigen";
    version = "1.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "zsh-users";
      repo = "antigen";
      rev = "v2.2.3";
      sha256 = "sha256-OB/NgpYTlMTHaohis2J/McS+oDHvDXND9FHVNnXjFsM=";  # Replace with correct hash
    };

    installPhase = ''
      mkdir -p $out/share/zsh/plugins/zsh-antigen
      cp antigen.zsh $out/share/zsh/plugins/zsh-antigen/
    '';
  };
}
