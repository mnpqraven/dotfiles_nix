{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  features = {
    kde.enable = true;
    hyprland.enable = true;
    nas.enable = true;
    nas.address = "nas.othi.dev";
  };

  services.xserver.xkb = {
    layout = "us,";
    variant = "colemak,";
    options = "grp:win_space_toggle";
  };

  environment.systemPackages = with pkgs; [
    librewolf
  ];
}
