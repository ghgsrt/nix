{ config, pkgs, inputs, lib,... }: {
  home.packages = [
    (pkgs.writeShellScriptBin "wayland-session" ''
      /run/current-system/systemd/bin/systemctl --user start graphical-session.target
      dbus-run-session "$@"
      /run/current-system/systemd/bin/systemctl --user stop graphical-session.target
    '')
  ];

#  services.xserver = {
#    enable = true;

#    displayManager.startx.enable = true;

#    dpi = 96;
#
 #   excludePackages = with pkgs; [
  #    xterm
   # ];
  #};

  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
  };
}
