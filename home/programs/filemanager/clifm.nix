{
  pkgs,
  config,
  osConfig,
  ...
}:
{
  home.packages = with pkgs; [
    clifm
  ];
  xdg.configFile.clifm.source = config.lib.file.mkOutOfStoreSymlink "${osConfig.flake.repoPath}/.config/clifm";
}
