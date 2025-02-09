{ config, pkgs, inputs, lib,... }:
{
  wayland.windowManager.sway.enable = true;

  home.packages = [
    (pkgs.writeShellScriptBin "wayland-session" ''
      /run/current-system/systemd/bin/systemctl --user start graphical-session.target
      dbus-run-session "$@"
      /run/current-system/systemd/bin/systemctl --user stop graphical-session.target
    '')
  ];
}
