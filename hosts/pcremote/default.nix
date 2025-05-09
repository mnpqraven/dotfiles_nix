{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "pcremote";

  features = {
    x11.enable = true;
    kde.enable = true;
    syncthing = {
      enable = true;
      user = "othi";
    };
    hyprland.enable = true;
    nas = {
      enable = true;
      address = "nas.othi.dev";
    };
  };

  environment.systemPackages = with pkgs; [
    librewolf
  ];
}
