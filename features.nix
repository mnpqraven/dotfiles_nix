{ lib, ... }:
with lib;
{
  options.features = {
    kde.enable = mkEnableOption "KDE Plasma";
    hyprland.enable = mkEnableOption "Hyprland";
    autoUpgrade.enable = mkEnableOption "system auto upgrade";
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
