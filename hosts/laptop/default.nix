{ pkgs, ... }:
{
  imports = [
    # TODO: dyn
    ../../users/othi/nixos.nix
    # uncomment this if you don't have a custom host and certificate ruleset
    ./private/network.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  features = {
    x11.enable = false;
    wayland.enable = true;
    kde.enable = false;

    editors.helix.enable = true;
    editors.helix.defaultEditor = true;

    terminal.default = "ghostty";
    database.enable = true;
    syncthing = {
      enable = true;
      user = "othi";
    };
    desktops = {
      niri.enable = true;
      hyprland.enable = true;
    };

    nas = {
      enable = false;
      address = "othiremote.synology.me";
    };
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
