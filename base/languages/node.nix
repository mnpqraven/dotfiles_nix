{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs_20
    pnpm
  ];
}
