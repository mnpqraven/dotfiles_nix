{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  device = osConfig.networking.hostName;
in
lib.mkIf osConfig.features.desktops.niri.enable {
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
    ];
  };
  xdg.configFile.niri = {
    target = "./niri/config.kdl";
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/niri/${device}.kdl";
  };
  # DEV: buggy as hell
  home.pointerCursor = {
    gtk.enable = true;
    enable = true;
    name = "Rose Pine Cursor";
    package = pkgs.rose-pine-cursor;
    size = 24;
  };
}
