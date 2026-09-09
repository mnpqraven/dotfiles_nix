{
  config,
  lib,
  pkgs,
  ...
}:
let
  xwayland-satellite = pkgs.xwayland-satellite.overrideAttrs (oldAttrs: rec {
    version = "0.8.1";
    src = pkgs.fetchFromGitHub {
      owner = "Supreeeme";
      repo = "xwayland-satellite";
      tag = "v0.8.1";
      hash = "sha256-BUE41HjLIGPjq3U8VXPjf8asH8GaMI7FYdgrIHKFMXA=";
    };
    cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-16L6gsvze+m7XCJlOA1lsPNELE3D364ef2FTdkh0rVY=";
    };
  });
in
lib.mkIf config.features.desktops.niri.enable {
  programs.niri.enable = true;

  environment.systemPackages = [
    xwayland-satellite
  ];
  # https://wiki.nixos.org/wiki/Niri
  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
}
