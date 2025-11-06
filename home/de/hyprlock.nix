{ config, ... }:
{
  xdg.configFile.hyprlock = {
    target = "./hypr/hyprlock.conf";
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/hypr/hyprlock.conf";
    force = true;
  };
}
