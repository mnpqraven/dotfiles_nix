_: {
  programs.nvf.settings.vim.autocomplete = {
    blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;

      mappings = {
        scrollDocsDown = "<C-d>";
        scrollDocsUp = "<C-u>";
      };
      setupOpts = {
        keymap.preset = "default";

        # NOTE: not in nvf doc
        appearance.nerd_font_variant = "mono";
        signature.enabled = true;
      };
    };
  };
}
