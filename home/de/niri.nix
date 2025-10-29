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
  xdg.configFile.niri = {
    target = "./niri/config.kdl";
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/niri/${device}.kdl";
    force = true;
  };
  home.pointerCursor = {
    name = "graphite-dark";
    size = 32;
    package = pkgs.graphite-cursors;
    x11.enable = true;
    gtk.enable = true;
  };
}
