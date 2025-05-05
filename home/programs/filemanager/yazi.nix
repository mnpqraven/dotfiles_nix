{
  pkgs,
  config,
  inputs,
  ...
}:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;
  yazi = inputs.yazi.packages."${pkgs.system}".yazi;
in
{
  programs.yazi = {
    enable = true;
    package = yazi;
  };
  # FIXME: dyn
  xdg.configFile.yazi.source = symlink "${config.home.homeDirectory}/dotfiles_nix/.config/yazi";
}
