{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "pcremote";

  features = {
    x11.enable = false;
    kde.enable = false;
    terminal.default = "ghostty";
    database.enable = true;
    syncthing = {
      enable = true;
      user = "othi";
    };
    hyprland.enable = true;
    hyprland.bar = "waybar";
    nas = {
      enable = true;
      address = "othiremote.synology.me";
    };
  };

  environment.systemPackages = with pkgs; [
    librewolf
  ];
}
