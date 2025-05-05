{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    clifm
  ];
  # FIXME:
  xdg.configFile.clifm.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/clifm";
}
