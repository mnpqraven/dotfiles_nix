{ lib, ... }:
with lib;
let
  terminals = [
    "alacritty"
    "wezterm"
    "ghostty"
  ];
  browsers = [
    "brave"
    "librewolf"
  ];

  terminalEnum = mkOption {
    type = types.enum terminals;
    default = "alacritty";
    description = "default terminal emulator";
  };

in
{
  options.features = {
    x11.enable = mkEnableOption "X11 server";
    wayland.enable = mkEnableOption "Wayland protocol";
    kde.enable = mkEnableOption "KDE Plasma";

    editors = {
      nvim.enable = mkEnableOption "Neovim";
      nvim.defaultEditor = mkEnableOption "Neovim as default editor";
      helix.enable = mkEnableOption "Helix";
      helix.defaultEditor = mkEnableOption "Helix as default editor";
    };

    gaming.enable = mkEnableOption "Gaming related configurations";

    terminal.default = terminalEnum;

    webBrowser = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
      browsers = mkOption {
        type = types.listOf (types.enum browsers);
        default = [ "librewolf" ];
      };
    };

    desktops = {
      niri.enable = mkEnableOption "Niri";
      hyprland = {
        enable = mkEnableOption "Hyprland";
        bar = mkOption {
          type = types.enum [
            "waybar"
            "hyprpanel"
          ];
          default = "waybar";
        };
      };
    };

    autoUpgrade.enable = mkEnableOption "system auto upgrade";

    notifications.enable = mkOption {
      type = types.bool;
      default = true;
    };

    network = {
      cloudflare.enable = mkEnableOption "Cloudflare Warp DNS";
    };

    database = {
      enable = mkEnableOption "Postgres database";
    };
    syncthing = {
      enable = mkEnableOption "Syncthing service";
      user = mkOption {
        type = types.nonEmptyStr;
        example = "othi";
        description = "username of syncthing's target dir";
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

    users = mkOption {
      type = types.listOf types.str;
      default = [ "othi" ];
    };
  };
}
