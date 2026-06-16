{
  lib,
  osConfig,
  pkgs,
  inputs,
  ...
}:
lib.mkIf (builtins.elem "zen" osConfig.features.webBrowser.browsers) {
  home.packages = [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
