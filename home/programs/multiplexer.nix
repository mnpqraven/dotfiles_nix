{ config, ... }:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;
  cfg = "${config.home.homeDirectory}/dotfiles_nix/.config";
in
{
  programs.zellij.enable = true;
  xdg.configFile.zellij.source = symlink "${cfg}/zellij";
}
