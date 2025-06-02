_: {
  programs.nvf.settings.vim.autocomplete = {
    blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;

      mappings = {
        # WARN: kinda buggy
        close = "<C-h>";
        # confirm = "<C-e>";

        next = "<C-n>";
        previous = "<C-p>";
        scrollDocsDown = "<C-d>";
        scrollDocsUp = "<C-u>";
      };
      setupOpts = {
        # TODO: snippets
        # snippets.preset = "luasnip";
        # FIXME: dyn
        # sources.providers.snippets.opts.search_paths = [
        #   "/home/othi/dotfiles_nix/.config/nvim/snippets"
        # ];

        cmdline.completion.menu.auto_show = true;
        signature.enabled = true;

        completion.menu.draw.columns = [
          {
            "@1" = "label";
            "@2" = "label_description";
            gap = 4;
          }

          {
            "@1" = "kind_icon";
            "@2" = "kind";
            gap = 2;
          }
        ];
      };
    };
  };
}
