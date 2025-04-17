{ pkgs, ... }:
{
  imports = [
    ./nix.nix
    ./node.nix
    ./rust.nix
  ];
  environment.systemPackages = with pkgs; [
    gcc
    go
  ];
}
