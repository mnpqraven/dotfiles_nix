{ config, osConfig, ... }:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  xdg.configFile.hyprlock = {
    target = ".config/hypr/hyprlock.conf";
    source = symlink "${osConfig.flake.repoPath}/.config/hypr/hyprlock.conf";
    force = true;
  };
}
