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
  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  xdg.portal.config.niri = {
    "org.freedesktop.impl.portal.FileChooser" = [ "kde" ]; # or "kde"
  };
}
