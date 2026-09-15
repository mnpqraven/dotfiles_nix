{ osConfig, ... }:
{

  home.packages = [
    # TODO: symlink this .so and .lua to .config/nvim/lua
    # @see https://github.com/L3MON4D3/LuaSnip/blob/master/Makefile#L87
    # pkgs.luajitPackages.jsregexp
  ];

  programs.nvf.settings.vim.snippets = {
    luasnip = {
      enable = false;
      loaders = ''
        require("luasnip.loaders.from_vscode").lazy_load({ paths = "${osConfig.flake.repoPath}/.config/nvim/snippets" })
      '';
    };
  };
}
