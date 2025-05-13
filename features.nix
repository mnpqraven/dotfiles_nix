{ lib, ... }:
with lib;
{
  options.features = {
    # should we have wayland option ?
    x11.enable = mkEnableOption "X11 server";
    kde.enable = mkEnableOption "KDE Plasma";
    gaming.enable = mkEnableOption "Gaming related configurations";
    terminal.default = mkOption {
      type = types.enum [
        "alacritty"
        "wezterm"
        "ghostty"
        # "rio"
      ];
      default = "alacritty";
      description = "default terminal emulator";
    };
    webBrowser = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
      browsers =
        let
          supported = [
            "brave"
            "librewolf"
            "zen"
          ];
        in
        mkOption {
          type = lib.types.listOf (lib.types.enum supported);
          default = [ "librewolf" ];
        };
    };
    hyprland.enable = mkEnableOption "Hyprland";
    autoUpgrade.enable = mkEnableOption "system auto upgrade";
    network = {
      cloudflare.enable = mkOption {
        type = types.bool;
        default = true;
        description = "Cloudflare Warp DNS";
      };
    };
    syncthing.enable = mkEnableOption "Syncthing service";
    syncthing.user = mkOption {
      type = types.nonEmptyStr;
      example = "othi";
      description = "username of syncthing's target dir";
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
