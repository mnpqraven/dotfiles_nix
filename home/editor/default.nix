{
  osConfig,
  ...
}:
{
  imports = [
    ./helix.nix
    ./nvim
  ];
  programs.neovim.defaultEditor = osConfig.features.editors.nvim.defaultEditor;
  programs.helix.defaultEditor = osConfig.features.editors.helix.defaultEditor;
}
