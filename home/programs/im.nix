{config, ...}: let
  cfgPath = "${config.home.homeDirectory}/dotfiles_nix/.config/fcitx5";
in {
  xdg.configFile."fcitx5".source = config.lib.file.mkOutOfStoreSymlink cfgPath;
}
