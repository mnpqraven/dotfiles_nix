_:
let
  on = {
    enable = true;
  };
in
{
  programs.nvf.settings.vim.lsp = {
    enable = true;
    formatOnSave = true;
    mappings = {
      format = "<leader>o";
      goToDefinition = "<leader>gd";
      goToDeclaration = "<leader>gD";
      listReferences = "<leader>gr";
      hover = "K";
      signatureHelp = "<C-k>";
      goToType = "<leader>D";
      renameSymbol = "<leader>rn";
      codeAction = "<leader>qf";
      openDiagnosticFloat = "<leader><leader>";
    };
  };
  programs.nvf.settings.vim.languages = {
    nix = {
      enable = true;
      lsp.enable = true;
      lsp.server = "nixd";
      treesitter = on;
      extraDiagnostics = on;
      format = {
        enable = true;
        type = "nixfmt";
      };
    };
  };
}
