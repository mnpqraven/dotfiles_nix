{ config, ... }:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  services.easyeffects.enable = true;
  xdg.configFile."easyeffects/output".source =
    symlink "${config.home.homeDirectory}/dotfiles_nix/.config/easyeffects/output";
  imports = [
    ./mpd.nix
    ./rmpc.nix
  ];
}
