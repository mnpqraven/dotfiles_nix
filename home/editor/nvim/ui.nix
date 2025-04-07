_: {
  # NOTE: also includes some other ui elements
  # one that should be configured later is fidget (bottom right notifs)
  programs.nvf.settings.vim = {
    ui = {
      borders.enable = true;
      illuminate.enable = true;
    };
    notes.todo-comments = {
      enable = true;
      mappings.telescope = "<leader>fd";
      setupOpts.signs = false;
    };
    utility.snacks-nvim = {
      enable = true;
      # https://github.com/folke/snacks.nvim/?tab=readme-ov-file#%EF%B8%8F-configuration
      setupOpts = {
        bigfile.enabled = true;
        input.enabled = true;
        picker.enabled = true;
      };
    };

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
