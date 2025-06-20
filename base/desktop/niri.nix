{ config, lib, ... }:
lib.mkIf config.features.desktops.niri.enable {
  programs.niri.enable = true;
}
