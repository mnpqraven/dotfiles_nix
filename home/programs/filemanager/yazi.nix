{
  pkgs,
  config,
  osConfig,
  inputs,
  ...
}:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;
  yazi = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.yazi;
in
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    package = yazi;
  };
  xdg.configFile.yazi.source = symlink "${osConfig.flake.repoPath}/.config/yazi";
}
