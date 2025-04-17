{ pkgs, config, ... }:
let
  cfg = "${config.home.homeDirectory}/dotfiles_nix/.config";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = with pkgs; [
    rmpc
  ];
  xdg.configFile.rmpc.source = symlink "${cfg}/rmpc";
}
