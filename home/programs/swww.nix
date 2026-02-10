{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = [
    inputs.swww.packages.${pkgs.stdenv.hostPlatform.system}.swww
  ];
}
