{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.features.development.enable {
  environment.systemPackages = with pkgs; [
    nodejs_24
    pnpm
    tailwindcss-language-server
    emmet-language-server
  ];
}
