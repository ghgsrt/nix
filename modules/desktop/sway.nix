{ config, pkgs, inputs, ... }: {
  imports = [
    ./wayland.nix
  ];

  home.packages = with pkgs; [
    sway
    swaylock
    swayidle
    waybar
  ];

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "sway";
  };

  programs.sway.enable = true;
 security.pam.services.swaylock = {
   text = ''
     auth include login
   '';
 };
}
