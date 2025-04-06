{ inputs, ... }:
{
  programs.nvf.settings.vim.telescope = {
    enable = true;
    mappings = {
      open = "<leader>fx";
      diagnostics = "<leader>fp";
      findProjects = null;
      lspDocumentSymbols = "<leader>ft";
    };
  };
}
