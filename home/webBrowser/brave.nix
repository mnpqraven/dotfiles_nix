{
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf (builtins.elem "brave" osConfig.features.webBrowser.browsers) {
  home.packages = with pkgs; [
    brave
  ];
}
