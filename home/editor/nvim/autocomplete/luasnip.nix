{ lib, ... }:
{

  programs.nvf.settings.vim.snippets = {
    luasnip = {
      enable = true;
      loaders = ''
        local ls = require("luasnip")
        ls.filetype_extend("typescriptreact", { "typescript", "javascript" })
        ls.filetype_extend("typescript", { "javascript" })
        ls.filetype_extend("javascriptreact", { "javascript" })
        require("luasnip.loaders.from_lua").load({ paths = "~/dotfiles_nix/.config/nvim/snippets/" })
      '';
    };
  };
}
