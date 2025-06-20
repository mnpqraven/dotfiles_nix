{
  osConfig,
  inputs,
  lib,
  ...
}:
let
  inherit (inputs) nvf;
  enable = osConfig.features.editors.nvim.enable;
in
{
  imports = [
    nvf.homeManagerModules.default
    ./autocomplete
    ./git.nix
    ./hop.nix
    ./lsp.nix
    ./keys_colemak.nix
    ./mini.nix
    ./opt.nix
    ./telescope.nix
    ./tree.nix
    ./oil.nix
    ./ui.nix
  ];

  programs = {
    neovim.enable = enable;
    nvf.enable = enable;
  };

  programs.nvf.settings.vim = {
    viAlias = false;
    vimAlias = true;

    globals = {
      mapleader = " ";
    };
    binds.whichKey.enable = true;
  };
}
