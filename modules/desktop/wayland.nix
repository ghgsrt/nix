{ config, pkgs, inputs, lib,... }: {
  imports = [
    ./base.nix
  ];

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "wayland-session" ''
      /run/current-system/systemd/bin/systemctl --user start graphical-session.target
      dbus-run-session "$@"
      /run/current-system/systemd/bin/systemctl --user stop graphical-session.target
    '')
  ];

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
  };
}
