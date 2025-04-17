{ pkgs, config, ... }:
let
  cfg = "${config.home.homeDirectory}/dotfiles_nix/.config";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = with pkgs; [
    wezterm
  ];
  xdg.configFile.wezterm.source = symlink "${cfg}/wezterm";
}
