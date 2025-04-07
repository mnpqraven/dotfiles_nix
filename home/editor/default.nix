_: {
  imports = [
    ./helix.nix
    ./nvim
  ];
  # default editor
  programs.neovim.defaultEditor = true;
}
