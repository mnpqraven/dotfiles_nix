{
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf (builtins.elem "librewolf" osConfig.features.webBrowser.browsers) {
  home.packages = with pkgs; [
    librewolf
  ];
}
