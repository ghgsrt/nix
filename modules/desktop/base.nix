{ config, pkgs, inputs, ... }: {
   services.xserver = {
    enable = true;

    displayManager.gdm.enable = true;

    dpi = 96;

    excludePackages = with pkgs; [
      xterm
    ];
  };
}