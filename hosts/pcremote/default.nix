{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "pcremote";

  features = {
    x11.enable = false;
    wayland.enable = true;
    kde.enable = false;

    editors.helix.enable = true;
    editors.helix.defaultEditor = true;

    terminal.default = "ghostty";
    database.enable = true;
    syncthing = {
      enable = true;
      user = "othi";
    };
    hyprland.enable = true;
    hyprland.bar = "waybar";
    nas = {
      enable = false;
      address = "othiremote.synology.me";
    };
  };

  environment.systemPackages = with pkgs; [
    librewolf
  ];
}
