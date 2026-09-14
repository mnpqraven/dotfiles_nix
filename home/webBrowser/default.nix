{
  lib,
  osConfig,
  inputs,
  ...
}:
lib.optionalAttrs osConfig.features.webBrowser.enable {
  imports = [
    inputs.zen-browser.homeModules.beta
    ./brave.nix
    ./helium.nix
    ./librewolf.nix
    ./zen.nix
  ];
}
