{
  config,
  osConfig,
  lib,
  ...
}:
let
  device = osConfig.networking.hostName;
in
lib.mkIf osConfig.features.desktops.niri.enable {
  xdg.configFile.niri = {
    target = "./niri/config.kdl";
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/niri/${device}.kdl";
  };
}
