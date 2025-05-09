{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./gaming.nix
    # PC needs NVIDIA configs as well
    ./nvidia.nix
  ];

  networking.hostName = "pc";

  features = {
    x11.enable = true;
    kde.enable = false;
    hyprland.enable = true;
    gaming.enable = true;
    webBrowser.browsers = [
      "brave"
      "librewolf"
      "zen"
    ];
    syncthing = {
      enable = true;
      user = "othi";
    };
    nas = {
      enable = true;
      address = "192.168.1.14";
    };
    autoUpgrade.enable = true;
  };

  environment.systemPackages = with pkgs; [
    librewolf
  ];
}
