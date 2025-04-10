_: {
  programs.nvf.settings.vim.telescope = {
    enable = true;
    mappings = {
      open = "<leader>fx";
      diagnostics = "<leader>fp";
      findProjects = null;
      lspDocumentSymbols = "<leader>ft";
    };
    setupOpts = {
      defaults.file_ignore_patterns = [
       "node_modules"
        "%.git/"
        "dist/"
        "build/"
        "target/"
        "result/" 
        ".next"
      ];
    };
  };
}
