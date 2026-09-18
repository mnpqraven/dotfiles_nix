{ pkgs, ... }:
{
  imports = [
    # uncomment this if you don't have a custom host and certificate ruleset
    ./network.nix
    ./keyboard.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  features = {
    x11.enable = true;
    wayland.enable = true;
    kde.enable = true;

    editors.helix.enable = true;
    editors.helix.defaultEditor = true;

    network.cloudflare.enable = true;
    terminal = {
      default = "ghostty";
      packages = [
        "alacritty"
        "ghostty"
      ];
    };
    webBrowser.browsers = [
      "zen"
      "helium"
    ];
    database.enable = true;
    services = {
      vpn.gui.enable = true;
      syncthing = {
        enable = true;
        user = "othi";
      };
    };
    desktops = {
      niri.enable = true;
    };

    nas = {
      enable = true;
      address = "othiremote.synology.me";
    };

    tools.slop.enable = true;
  };

  environment.systemPackages = with pkgs; [
    anki
    libreoffice
    slack
    vlc
  ];
}
