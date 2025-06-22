{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}:
let
  enable =
    if osConfig.features.hyprland.enable then
      osConfig.features.hyprland.bar == "waybar"
    # niri uses waybar
    else
      true;

  sharedBlocks = (import ./modules/shared.nix) { };
  de = (import ./modules/de.nix) { };
  isHyprland = builtins.getEnv "XDG_CURRENT_DESKTOP" == "Hyprland";

  # TODO: niri modules
  workspaces = if isHyprland then "hyprland/workspaces" else "hyprland/workspaces";
  window = if isHyprland then "hyprland/window" else "hyprland/window";
in
{
  programs.waybar = {
    inherit enable;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        mode = "dock";
        margin-left = 12;
        margin-right = 12;
        margin-top = 6;
        margin-bottom = 0;
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;
        reload_style_on_change = true;
        # TODO: monitors per device
        # output = [
        #   "eDP-1"
        #   "HDMI-A-1"
        # ];
        modules-left =
          [
            "custom/padd"
            "custom/terminal"
            workspaces
            "custom/pad"
          ]
          ++ lib.optional isHyprland "hyprland/submap"
          ++ [
            "custom/pad"
            "mpd"
          ]
          ++ lib.optional osConfig.services.mpd.enable "mpd";
        modules-center = [
          "custom/padd"
          window
          "custom/padd"
        ];
        modules-right =
          [
            "group/expand-tray"
            "network"
            "group/expand-volume"
            "memory"
            "custom/pad"
            "cpu"
            "custom/pad"
          ]
          ++ lib.optional osConfig.features.network.cloudflare.enable "custom/cloudflare"
          ++ [
            "clock"
            "group/group-power"
            "custom/padd"
          ];

        inherit (de)
          "hyprland/window"
          "hyprland/workspaces"
          "hyprland/submap"
          ;

        inherit (sharedBlocks)
          "custom/pad"
          "custom/padd"
          "group/group-power"
          "group/expand-volume"
          "pulseaudio"
          "pulseaudio/slider"
          "custom/quit"
          "custom/lock"
          "custom/reboot"
          "custom/power"
          "custom/terminal"
          "custom/cloudflare"
          "memory"
          "cpu"
          "mpd"
          "group/expand-tray"
          "custom/expand-left"
          "tray"
          "network"
          ;
      };
    };
  };

  # FIXME: dyn
  # xdg.configFile.waybar.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/waybar";
}
