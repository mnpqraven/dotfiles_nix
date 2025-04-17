{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bacon
    rustup
  ];
}
