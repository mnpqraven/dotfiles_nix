{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gojq
  ];
}
