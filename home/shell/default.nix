{ config, inputs, pkgs, ... }: {
  imports = [ ./zoxide.nix ./starship ./alacritty.nix ./zsh.nix ];
}
