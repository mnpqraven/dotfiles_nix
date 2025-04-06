{ config, ... }:
let
  cfgPath = "${config.home.homeDirectory}/dotfiles_nix/.config/ags";
in
{
  xdg.configFile."ags".source = config.lib.file.mkOutOfStoreSymlink cfgPath;
}
