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
