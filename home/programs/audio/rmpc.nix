{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rmpc
  ];
}
