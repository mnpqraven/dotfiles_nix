{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./gaming
  ];

  features = {
    x11.enable = true;
    wayland.enable = true;
    kde.enable = true;

    editors = {
      nvim.enable = false;
      helix.enable = true;
      helix.defaultEditor = true;
    };

    terminal.default = "ghostty";
    desktops = {
      niri.enable = true;
    };

    gaming.enable = true;
    webBrowser.browsers = [
      "brave"
      "zen"
    ];
    network.cloudflare.enable = true;
    database.enable = true;
    services = {
      vpn.gui.enable = true;
      syncthing = {
        enable = true;
        user = "othi";
      };
    };
    nas = {
      enable = true;
      address = "192.168.1.14";
    };
    tools = {
      obs.enable = true;
      discord.enable = true;
      torrent.enable = true;
    };
    autoUpgrade.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libreoffice
    slack
    vlc
  ];
}
