{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf
  (osConfig.features.notifications.enable && osConfig.features.desktops.hyprland.bar == "waybar")
  {
    home.packages = with pkgs; [
      dunst
    ];
    xdg.configFile.dunst.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/dunst";
  }
