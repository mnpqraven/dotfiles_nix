{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "pcremote";

  features = {
    kde.enable = true;
    hyprland.enable = true;
    nas.enable = true;
    nas.address = "nas.othi.dev";
  };

  environment.systemPackages = with pkgs; [
    librewolf
  ];
}
