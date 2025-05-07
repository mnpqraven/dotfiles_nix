{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  device = osConfig.networking.hostName;
in
lib.mkIf osConfig.features.hyprland.enable {
  home.packages = with pkgs; [
    gojq
  ];

  # FIXME: dyn
  xdg.configFile.hypr.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/hypr";

  # dynamically creates hyprland config
  # FIXME: new installation needs to run 2 different builds, each build with
  # one file section commented out to correctly populate the symlinks
  home.file.".config/hypr/hyprland.conf" = {
    force = true;
    text = ''
      source = ./hyprland/set.conf

      source = ./hyprland/monitors_${device}.conf
      source = ./hyprland/startup.conf
      source = ./hyprland/wallpaper_${device}.conf
      source = ./hyprland/animations.conf
      source = ./hyprland/rules.conf
      source = ./hyprland/bindings.conf
      source = ./hyprland/looks.conf
    '';
  };
}
