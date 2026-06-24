{
  lib,
  osConfig,
  pkgs,
  inputs,
  ...
}:
lib.mkIf (builtins.elem "helium" osConfig.features.webBrowser.browsers) {
  home.packages = with pkgs; [
    inputs.helium-nix.packages.${stdenv.hostPlatform.system}.helium
  ];
}
