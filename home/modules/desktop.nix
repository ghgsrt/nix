{ lib, ... }:

let
  inherit (import ../../lib { inherit lib; }) mkComposableModule;
in

mkComposableModule {
  name = "desktop.base";
  packages = [
    "xdg-utils"
    "brightnessctl"
    "playerctl"
  ];
}

mkComposableModule {
  name = "desktop.wayland";
  packages = [
    "wayland"
    "xwayland"
    "qt5.qtwayland"
    "qt6.qtwayland"
  ];
  variables = {
    XDG_SESSION_TYPE = "wayland";
  };
  imports = [
    ./base.nix
  ];
}

mkComposableModule {
  name = "desktop.sway";
  packages = [
    "sway"
    "swaylock"
    "swayidle"
    "waybar"
  ];
  variables = {
    XDG_CURRENT_DESKTOP = "sway";
  };
  imports = [
    ./wayland.nix
  ];
}