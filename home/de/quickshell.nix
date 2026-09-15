{
  pkgs,
  config,
  osConfig,
  inputs,
  ...
}:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;
  quickshell = inputs.qml-niri.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
in
{
  home.packages = with pkgs; [
    quickshell
    kdePackages.qtdeclarative
  ];
  xdg.configFile.quickshell = {
    target = "${config.home.homeDirectory}/.config/quickshell";
    source = symlink "${osConfig.flake.repoPath}/.config/quickshell";
    recursive = true;
  };
}
