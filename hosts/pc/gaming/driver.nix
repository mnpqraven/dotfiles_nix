{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.features.gaming.enable {
  # @see https://www.talesign.com/blog/nixology/sq-gaming-on-nixos
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva-vdpau-driver
        nvidia-vaapi-driver
      ];
    };

    # NVIDIA config
    nvidia = {
      branch = "production";
      open = false;
      # must-have for wayland
      # https://wiki.nixos.org/wiki/NVIDIA#Wayland
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      forceFullCompositionPipeline = false;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
}
