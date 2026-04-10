{ config, ... }:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  xdg.configFile.hyprlock = {
    target = ".config/hypr/hyprlock.conf";
    source = symlink "${config.home.homeDirectory}/dotfiles_nix/.config/hypr/hyprlock.conf";
    force = true;
  };
}
