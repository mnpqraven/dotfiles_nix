{
  pkgs,
  config,
  inputs,
  ...
}:
let
  cfg = "${config.home.homeDirectory}/dotfiles_nix/.config";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = with pkgs; [
    gojq
  ];

  xdg.configFile.hypr.source = symlink "${cfg}/hypr";

  # dynamically creates hyprland config
  # FIXME: new installation needs to run 2 different builds, each build with
  # one file section commented out to correctly populate the symlinks
  home.file.".config/hypr/hyprland.conf" = {
    force = true;
    text = ''
      source = ./hyprland/set.conf

      source = ./hyprland/monitors_${inputs.device}.conf
      source = ./hyprland/startup.conf
      source = ./hyprland/wallpaper_${inputs.device}.conf
      source = ./hyprland/animations.conf
      source = ./hyprland/rules.conf
      source = ./hyprland/bindings.conf
      source = ./hyprland/looks.conf
    '';
  };
}
