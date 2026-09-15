{
  pkgs,
  config,
  osConfig,
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
  xdg.configFile."rmpc".source =
    config.lib.file.mkOutOfStoreSymlink "${osConfig.flake.repoPath}/.config/rmpc";
}
