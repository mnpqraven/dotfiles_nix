{
  pkgs,
  osConfig,
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

  xdg.configFile.lazygit.source = symlink "${osConfig.flake.repoPath}/.config/lazygit";
}
