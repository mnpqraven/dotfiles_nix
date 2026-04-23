{ pkgs, config, ... }:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = with pkgs; [
    quickshell
    kdePackages.qtdeclarative
  ];
  xdg.configFile.quickshell = {
    target = "${config.home.homeDirectory}/.config/quickshell";
    source = symlink "${config.home.homeDirectory}/dotfiles_nix/.config/quickshell";
    recursive = true;
  };
}
