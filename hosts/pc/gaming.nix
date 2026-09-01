{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.features.gaming.enable {
  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    nvidia.modesetting.enable = true;
  };
  programs = {
    steam.enable = true;
    steam.gamescopeSession.enable = true;

    gamemode.enable = true;
    gamescope.enable = true;
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
    wineWowPackages.waylandFull

    # lossless scaling
    lsfg-vk
    lsfg-vk-ui
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
