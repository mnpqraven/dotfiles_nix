{ pkgs, ... }:
{
  imports = [
    # TODO: dyn
    ../../users/othi/nixos.nix
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

    terminal.default = "alacritty";

    network.cloudflare.enable = true;
    database.enable = true;
    syncthing = {
      enable = true;
      user = "othi";
    };
    nas = {
      enable = false;
      address = "192.168.1.14";
    };
    autoUpgrade.enable = false;
  };
}
