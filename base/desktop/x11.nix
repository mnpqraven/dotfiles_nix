{ config, lib, ... }:
lib.mkIf config.features.x11.enable {
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
}
