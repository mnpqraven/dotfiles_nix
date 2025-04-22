{ lib, pkgs, ... }:
{

  home.packages = [
    # TODO: symlink this .so and .lua to .config/nvim/lua
    # @see https://github.com/L3MON4D3/LuaSnip/blob/master/Makefile#L87
    # pkgs.luajitPackages.jsregexp
  ];

  programs.nvf.settings.vim.snippets = {
    luasnip = {
      enable = false;
      # loaders = ''
      #   local ls = require("luasnip")
      #   ls.filetype_extend("typescriptreact", { "typescript", "javascript" })
      #   ls.filetype_extend("typescript", { "javascript" })
      #   ls.filetype_extend("javascriptreact", { "javascript" })
      #   require("luasnip.loaders.from_lua").load({ paths = "~/dotfiles_nix/.config/nvim/snippets/" })
      # '';
      loaders = ''
        require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/dotfiles_nix/.config/nvim/snippets" })
      '';
    };
  };
}
