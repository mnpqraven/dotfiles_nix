{ lib, osConfig, ... }:
lib.optionalAttrs osConfig.features.webBrowser.enable {
  imports = [
    ./brave.nix
    ./librewolf.nix
  ];
}
