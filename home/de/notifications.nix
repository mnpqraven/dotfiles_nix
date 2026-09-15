{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf (osConfig.features.notifications.enable) {
  home.packages = with pkgs; [
    dunst
  ];
  xdg.configFile.dunst.source = config.lib.file.mkOutOfStoreSymlink "${osConfig.flake.repoPath}/.config/dunst";
}
