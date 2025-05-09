{ lib, ... }:
with lib;
{
  options.features = {
    # should we have wayland option ?
    x11.enable = mkEnableOption "X11 server";
    kde.enable = mkEnableOption "KDE Plasma";
    hyprland.enable = mkEnableOption "Hyprland";
    autoUpgrade.enable = mkEnableOption "system auto upgrade";
    network = {
      cloudflare.enable = mkOption {
        type = types.bool;
        default = true;
        description = "Cloudflare Warp DNS";
      };
    };
    nas = {
      enable = mkEnableOption "NAS mounting";
      address = mkOption {
        type = types.nonEmptyStr;
        example = "192.168.1.14";
        description = "address of the nas mount";
      };
    };
  };
}
