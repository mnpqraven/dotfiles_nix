{ pkgs, config, ... }:
let
  cfg = "${config.home.homeDirectory}/dotfiles_nix/.config";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = with pkgs; [
    yazi
  ];
  programs.yazi.enable = true;
  xdg.configFile.yazi.source = symlink "${cfg}/yazi";
}
