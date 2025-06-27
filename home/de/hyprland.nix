{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  hyprlandCfg = osConfig.features.desktops.hyprland;
  device = osConfig.networking.hostName;
  dunstExec = if hyprlandCfg.bar != "hyprpanel" then "exec-once = dunst" else null;
in
lib.mkIf hyprlandCfg.enable {
  home.packages = with pkgs; [
    gojq
  ];

  # FIXME: dyn
  xdg.configFile.hypr.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/hypr";

  # dynamically creates hyprland config
  # FIXME: new installation needs to run 2 different builds, each build with
  # one file section commented out to correctly populate the symlinks
  home.file.".config/hypr/hyprland/startup.conf".text = ''
    exec-once = fcitx5
    exec-once = hypridle
    exec-once = ${hyprlandCfg.bar}
    exec-once = systemctl --user start hyprpolkitagent
    ${dunstExec}
  '';

  home.file.".config/hypr/hyprland.conf" = {
    force = true;
    # TODO: nixify the device confs
    text = ''
      source = ./hyprland/set.conf
      source = ./hyprland/startup.conf

      source = ./hyprland/by_${device}/monitors.conf
      source = ./hyprland/by_${device}/autostart.conf
      source = ./hyprland/by_${device}/wallpaper.conf

      source = ./hyprland/animations.conf
      source = ./hyprland/rules.conf
      source = ./hyprland/bindings.conf
      source = ./hyprland/looks.conf
    '';
  };
}
