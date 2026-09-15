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
    source = config.lib.file.mkOutOfStoreSymlink "${osConfig.flake.repoPath}/.config/niri/${device}.kdl";
    force = true;
  };
  xdg.configFile.common = {
    target = "./niri/common.kdl";
    source = config.lib.file.mkOutOfStoreSymlink "${osConfig.flake.repoPath}/.config/niri/common.kdl";
    force = true;
  };
  home.pointerCursor = {
    enable = true;
    name = "graphite-dark";
    size = 32;
    package = pkgs.graphite-cursors;
    x11.enable = true;
    gtk.enable = true;
  };
}
