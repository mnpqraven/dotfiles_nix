_: {
  programs.nvf.settings.vim.languages = {
    enableDAP = true;
    enableExtraDiagnostics = true;
    enableFormat = true;
    enableTreesitter = true;

    nix = {
      lsp.server = "nixd";
      enable = true;
      format.type = "nixfmt";
    };
    rust.enable = true;
    lua.enable = true;
    ts = {
      enable = true;
      extensions.ts-error-translator.enable = true;
      # FIXME: doesn't work yet (see NotAShelf/nvf#790)
      format.type = "biome";
    };
    markdown = {
      enable = true;
      extensions."render-markdown-nvim" = {
        enable = true;
      };
      extraDiagnostics.enable = true;
    };
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
