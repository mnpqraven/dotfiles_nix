{
  pkgs,
  config,
  ...
}:

let
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = with pkgs; [
    lazygit
  ];

  # FIXME: dyn
  xdg.configFile.lazygit.source = symlink "${config.home.homeDirectory}/dotfiles_nix/.config/lazygit";
}
