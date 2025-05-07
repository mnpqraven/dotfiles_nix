{ ... }:
{
  imports = [
    ./lock.nix
    ./hyprland.nix
    # TODO: feature gate
    ./kde.nix
    ./x11.nix
  ];
}
