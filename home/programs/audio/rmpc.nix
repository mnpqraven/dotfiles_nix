{
  pkgs,
  config,
  inputs,
  ...
}:
let
  rmpc = inputs.rmpc.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages = [
    rmpc
  ];
  # FIXME: dyn
  xdg.configFile."rmpc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/rmpc";
}
