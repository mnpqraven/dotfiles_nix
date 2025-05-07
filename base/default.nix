# INFO: base module that has shared settings between all users and devices
# this is basically the core level of configuration.nix
{ pkgs, ... }:
{
  imports = [
    ./audio.nix
    ./boot.nix
    ./cicd.nix
    ./desktop
    ./development.nix
    ./font.nix
    ./home-manager.nix
    ./languages
    ./locale.nix
    ./network.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # wayland wrapper flag for electron and chromium apps
  environment.sessionVariables.NIXOS_OZONE_WL = 1;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
