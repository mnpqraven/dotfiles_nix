{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./helix.nix
    ./nvim
  ];
  # default editor
  programs.neovim.defaultEditor = true;
}
