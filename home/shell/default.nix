{ pkgs, ... }:
{
  imports = [
    ./zoxide.nix
    ./starship.nix
    ./alacritty.nix
    ./zsh.nix
    ./wezterm.nix
    ./direnv.nix
  ];
}
