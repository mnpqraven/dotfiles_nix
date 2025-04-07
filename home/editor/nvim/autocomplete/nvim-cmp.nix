_: {
  programs.nvf.settings.vim.autocomplete.nvim-cmp = {
    enable = true;

    mappings = {
      # WARN: kinda buggy
      close = "<C-h>";
      confirm = "<C-e>";

      next = "<C-n>";
      previous = "<C-p>";
      scrollDocsDown = "<C-d>";
      scrollDocsUp = "<C-u>";
    };
  };
}
