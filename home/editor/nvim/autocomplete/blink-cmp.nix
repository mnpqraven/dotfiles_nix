{ lib, ... }:
{
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
        # DEV:
        # snippets.preset = "luasnip";
        # FIXME: dyn
        # TODO:
        # sources.providers.snippets.opts.search_paths = [
        #   "/home/othi/dotfiles_nix/.config/nvim/snippets"
        # ];

        cmdline.completion.menu.auto_show = true;

        # keymap = {
        #   "<C-h>" = [ "cancel" ];
        #   "<CR>" = [
        #     "accept"
        #     "fallback"
        #   ];
        # };

        # nvim-cmp-like menu drawing
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
          # or this syntax if gap is not needed
          # [
          #   "kind_icon"
          #   "kind"
          # ]
        ];
      };
    };
  };
}
