{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.features.development.enable {
  environment.systemPackages = with pkgs; [
    nixd
    nixfmt
  ];
}
