{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.features.gaming.enable {
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    (heroic.override {
      extraPkgs = pkgs: [
        pkgs.gamescope
      ];
    })
    mangohud
    protonup-ng
    protonplus

    wineWow64Packages.staging
    # winetricks (all versions)
    winetricks
    # for wine
    cabextract
    # native wayland support (unstable)
    wineWow64Packages.waylandFull

    # lossless scaling
    lsfg-vk
    lsfg-vk-ui
  ];
}
