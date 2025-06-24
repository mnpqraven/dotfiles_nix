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
}
