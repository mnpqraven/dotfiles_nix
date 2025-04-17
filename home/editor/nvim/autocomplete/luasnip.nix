{ lib, ... }:
{

  programs.nvf.settings.vim.snippets = {
    luasnip = {
      enable = true;
      loaders = lib.generators.mkLuaInline ''
        require("luasnip.loaders.from_lua").load({ paths = "~/dotfiles_nix/.config/nvim/snippets/" })
      '';
    };
  };
}
