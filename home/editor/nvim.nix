{ inputs, ... }: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        vialias = false;
        vimalias = true;

        lsp.enable = true;

      };
    };
  };
}
