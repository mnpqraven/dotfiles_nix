_: {
  programs.nvf.settings.vim.ui = {
    noice.enable = true;
  };
  programs.nvf.settings.vim.notes.todo-comments = {
    enable = true;
    mappings.telescope = "<leader>fd";
    setupOpts.signs = false;
  };
}
