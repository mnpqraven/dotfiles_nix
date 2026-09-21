{ pkgs, ... }:
{
  imports = [
    ./nix.nix
    ./node.nix
    ./rust.nix
    ./csharp.nix
  ];
  environment.systemPackages = with pkgs; [
    gcc
    go
  ];
}
