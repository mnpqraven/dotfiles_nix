{ config, ... }:
let
  cfgPath = "${config.home.homeDirectory}/dotfiles_nix/.config/hypr";
in
{
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink cfgPath;
}
