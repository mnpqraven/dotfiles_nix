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
    "zen"
    "helium"
  ];

  terminalEnum = mkOption {
    type = types.enum terminals;
    default = "alacritty";
    description = "default terminal emulator";
  };

in
{
  options.flake.repoPath = mkOption {
    type = types.str;
    default = "/home/othi/dotfiles_nix";
    description = "path to the flake repo (relative in home directory)";
  };
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

    development.enable = mkOption {
      type = types.bool;
      default = true;
    };

    gaming.enable = mkEnableOption "Gaming related configurations";

    terminal = {
      default = terminalEnum;
      packages = mkOption {
        type = types.listOf (types.enum terminals);
        default = terminals;
      };
    };

    webBrowser = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
      browsers = mkOption {
        type = types.listOf (types.enum browsers);
        default = [ "zen" ];
      };
    };

    desktops = {
      niri.enable = mkEnableOption "Niri";
      hyprland = {
        enable = mkEnableOption "Hyprland";
        bar = mkOption {
          type = types.enum [
            "hyprpanel"
          ];
          default = "hyprpanel";
        };
      };
    };

    autoUpgrade.enable = mkEnableOption "system auto upgrade";

    notifications.enable = mkOption {
      type = types.bool;
      default = true;
    };

    database = {
      enable = mkEnableOption "Postgres database";
    };

    services = {
      syncthing = {
        enable = mkEnableOption "Syncthing service";
        user = mkOption {
          type = types.nonEmptyStr;
          example = "othi";
          description = "username of syncthing's target dir";
        };
      };
      vpn = {
        enable = mkOption {
          type = types.bool;
          default = true;
        };
        autostart = mkOption {
          type = types.bool;
          default = true;
        };
        gui.enable = mkEnableOption "GUI application for VPN";
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

    tools = {
      obs.enable = mkEnableOption "OBS studio";
      discord.enable = mkEnableOption "discord";
      torrent.enable = mkEnableOption "torrenting";
      slop.enable = mkEnableOption "AI features";
    };

    users = mkOption {
      type = types.listOf types.str;
      default = [ "othi" ];
    };
  };
}
