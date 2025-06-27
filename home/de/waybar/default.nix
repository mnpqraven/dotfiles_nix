{
  lib,
  osConfig,
  ...
}:
let
  hyprlandCfg = osConfig.features.desktops.hyprland;
  enable =
    if hyprlandCfg.enable then
      hyprlandCfg.bar == "waybar"
    # niri uses waybar
    else
      true;

  sharedBlocks = (import ./modules/shared.nix) { };
  de = (import ./modules/de.nix) { };
  isHyprland = builtins.getEnv "XDG_CURRENT_DESKTOP" == "Hyprland";
in
{
  programs.waybar = {
    inherit enable;

    style = ./style.css;
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
            "hyprland/workspaces"
            "niri/workspaces"
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
          "hyprland/window"
          "niri/window"
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
          "hyprland/workspaces"
          "hyprland/window"
          "hyprland/submap"
          "niri/workspaces"
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
  # xdg.configFile.waybar-css = {
  #   target = "${config.home.homeDirectory}/.config/waybar/style.css";
  #   source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/waybar/style.css";
  # };
}
