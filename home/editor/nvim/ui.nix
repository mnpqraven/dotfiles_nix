_: {
  programs.nvf.settings.vim = {
    ui = {
      noice = {
        enable = true;
        setupOpts = {
          lsp.progress.enabled = false;
          notify.enabled = false;
        };
      };

      colorizer.enable = true;
      borders.enable = true;
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
        picker = {
          enabled = true;
          ui_select = true;
        };
        input.enabled = true;
        indent.enabled = true;
        bigfile.enabled = true;
        words.enabled = true;
      };
    };

    visuals.nvim-web-devicons.enable = true;

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
