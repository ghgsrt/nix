{ config, pkgs, inputs, ... }: {
  imports = [
    ./wayland.nix
  ];

  environment.systemPackages = with pkgs; [
    sway
    swaylock
    swayidle
    waybar
  ];

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "sway";
  };

  programs.sway.enable = true;
 security.pam.services.swaylock = {
   text = ''
     auth include login
   '';
 };
}
