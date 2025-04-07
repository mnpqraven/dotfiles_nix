{ inputs, config, ... }:
{
  imports = [
    ./autocomplete
    ./git.nix
    ./hop.nix
    ./lsp.nix
    ./keys_colemak.nix
    ./mini.nix
    ./opt.nix
    ./telescope.nix
    ./tree.nix
    ./ui.nix
  ];

  programs.neovim.enable = true;
  programs.nvf.enable = true;

  programs.nvf.settings.vim = {
    viAlias = false;
    vimAlias = true;

    globals = {
      mapleader = " ";
    };
    binds.whichKey.enable = true;

    autocmds = [
      {
        enable = true;
        desc = "Trim whitespace";
        command = "%s/\\s\\+$//e";
        event = [ "BufWritePre" ];
      }
    ];

    visuals.nvim-web-devicons.enable = true;
    visuals.indent-blankline.enable = true;

    statusline.lualine = {
      enable = true;
      theme = "tokyonight";
      refresh = {
        statusline = 200;
        tabline = 200;
        winbar = 200;
      };
    };

    theme = {
      enable = true;
      name = "tokyonight";
      style = "night";
    };
  };
}
