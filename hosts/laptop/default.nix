{ pkgs, ... }:
{
  imports = [
    # TODO: dyn
    ../../users/othi/nixos.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  features = {
    x11.enable = true;
    kde.enable = true;
    terminal.default = "wezterm";
    hyprland.enable = true;
    syncthing = {
      enable = true;
      user = "othi";
    };
    nas = {
      enable = true;
      address = "nas.othi.dev";
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
