_: {
  programs.nvf.settings.vim.languages = {
    enableLSP = true;
    enableDAP = true;
    enableExtraDiagnostics = true;
    enableFormat = true;
    enableTreesitter = true;

    nix.enable = true;
    rust.enable = true;
    ts.enable = true;
  };

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
}
