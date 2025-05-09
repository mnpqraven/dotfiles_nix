{
  osConfig,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  zen-browser = inputs.zen-browser.packages."${pkgs.system}".default;
in
lib.mkIf (builtins.elem "zen" osConfig.features.webBrowser.browsers) {
  home.packages = [
    zen-browser
  ];
}
