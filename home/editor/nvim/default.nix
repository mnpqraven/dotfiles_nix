{ inputs, config, ... }:
{
  imports = [
    ./hop.nix
    ./lsp.nix
    ./keys_colemak.nix
    ./keys_lsp.nix
    ./mini.nix
    ./opt.nix
    ./telescope.nix
    ./tree.nix
  ];

  programs.nvf.enable = true;

  programs.nvf.settings.vim = {
    viAlias = false;
    vimAlias = true;

    git.enable = true;

    globals = {
      mapleader = " ";
    };
    binds = {
      whichKey.enable = true;
    };

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
        statusline = 300;
        tabline = 300;
        winbar = 300;
      };
    };

    theme = {
      enable = true;
      name = "tokyonight";
      style = "night";
    };
  };
}
