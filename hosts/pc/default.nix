{ pkgs, ... }:
{
  imports = [
    # TODO: dyn
    ../../users/othi/nixos.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./gaming.nix
    # PC needs NVIDIA configs as well
    ./nvidia.nix
  ];

  features = {
    x11.enable = false;
    wayland.enable = true;
    kde.enable = false;

    editors = {
      nvim.enable = false;
      helix.enable = true;
      helix.defaultEditor = true;
    };

    terminal.default = "ghostty";
    desktops = {
      niri.enable = true;
      hyprland.enable = true;
    };

    gaming.enable = true;
    webBrowser.browsers = [
      "brave"
      "librewolf"
      "zen"
    ];
    network.cloudflare.enable = true;
    database.enable = true;
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
