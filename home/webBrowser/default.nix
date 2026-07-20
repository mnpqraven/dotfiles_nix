{ lib, osConfig, ... }:
lib.optionalAttrs osConfig.features.webBrowser.enable {
  imports = [
    ./brave.nix
    ./helium.nix
    ./librewolf.nix
    ./zen.nix
  ];
}
