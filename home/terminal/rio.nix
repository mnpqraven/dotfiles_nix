{
  config,
  inputs,
  pkgs,
  ...
}:
{
  programs.rio = {
    enable = true;
    package = inputs.rio.packages."${pkgs.system}".rio;
  };
  # FIXME: dyn
  xdg.configFile.rio.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/rio";
}
