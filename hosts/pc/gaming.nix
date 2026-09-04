{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.features.gaming.enable {
  # @see https://www.talesign.com/blog/nixology/sq-gaming-on-nixos
  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;

    # NVIDIA config
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false;
      modesetting.enable = true;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  programs = {
    gamemode.enable = true;
    gamescope.enable = true;
  };
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

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
