{
  lib,
  osConfig,
  pkgs,
  inputs,
  ...
}:
lib.mkIf (builtins.elem "helium" osConfig.features.webBrowser.browsers) {
  home.packages = [
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
