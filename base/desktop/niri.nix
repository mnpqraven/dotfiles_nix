{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.features.desktops.niri.enable {
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
  # https://wiki.nixos.org/wiki/Niri
  xdg.portal.config.niri = {
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ]; # or "kde"
  };
}
