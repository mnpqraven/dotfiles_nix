{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs_24
    pnpm
    tailwindcss-language-server
    emmet-language-server
  ];
}
