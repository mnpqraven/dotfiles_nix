{
  config,
  osConfig,
  lib,
  ...
}:
lib.mkIf osConfig.features.desktops.niri.enable {
  xdg.configFile.niri.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/niri";
}
