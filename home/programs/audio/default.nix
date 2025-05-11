{ config, ... }:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  services.easyeffects.enable = true;
  xdg.configFile.easyeffects = {
    target = "${config.home.homeDirectory}/.config/easyeffect/output";
    source = symlink "${config.home.homeDirectory}/dotfiles_nix/.config/easyeffects/output";
    recursive = true;
    force = true;
  };
  imports = [
    ./mpd.nix
    ./rmpc.nix
  ];
}
