{ config, lib, ... }:
lib.mkIf config.features.kde.enable {
  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
}
