{lib, ...}: {
  programs.nvf.settings.vim.autocomplete = {
    blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;

      mappings = {
        # WARN: kinda buggy
        close = null;
        confirm = "<C-e>";

        next = "<C-n>";
        previous = "<C-p>";
        scrollDocsDown = "<C-d>";
        scrollDocsUp = "<C-u>";
      };
      setupOpts = {
        signature.enabled = true;
        fuzzy.implementation = "prefer_rust_with_warning";

        keymap = {
          "<C-h>" = ["cancel"];
          "<CR>" = [
            "accept"
            "fallback"
          ];
        };

        # nvim-cmp-like menu drawing
        completion.menu.draw.columns = [
          {
            "@1" = "label";
            "@2" = "label_description";
            gap = 4;
          }

          [
            "kind_icon"
            "kind"
          ]
        ];
      };
    };
  };
}
