# INFO: base module that has shared settings between all users and devices
# this is basically the core level of configuration.nix
{ ... }:
{
  imports = [
    ./caching.nix
    ./audio.nix
    ./boot.nix
    ./cicd.nix
    ./desktop
    ./development.nix
    ./font.nix
    ./home-manager.nix
    ./languages
    ./locale.nix
    ./nas.nix
    ./network
    ./secrets.nix
    ./qmk.nix
    ./system.nix
    ./upgrade.nix
  ];
}
