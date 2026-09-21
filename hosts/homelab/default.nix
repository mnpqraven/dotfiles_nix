{ ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "homelab";

  features = {
    editors = {
      nvim.enable = false;
      helix.enable = true;
      helix.defaultEditor = true;
    };

    development.enable = false;
    terminal.default = "alacritty";

    network.cloudflare.enable = true;
    database.enable = true;
    services = {
      vpn.enable = true;
      syncthing = {
        enable = true;
        user = "othi";
      };
    };
    nas = {
      enable = false;
      address = "192.168.1.14";
    };
    tools = {
      torrent.enable = true;
    };
    autoUpgrade.enable = false;
  };
}
