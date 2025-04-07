{lib, ...}: let
  on_attach = lib.generators.mkLuaInline ''
    function(bufnr)
        local api = require "nvim-tree.api"
        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)
        -- custom mappings
        vim.keymap.set("n", "<C-e>", "<cmd>:wincmd l<CR>", opts(""))
        vim.keymap.set("n", "e", function() end, opts(""))
        vim.keymap.set("n", "<C-n>", api.node.open.tab, opts("Edit in new tab"))
        vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Edit"))
        vim.keymap.set("n", "<C-o>", api.node.open.edit, opts("Edit"))
        vim.keymap.set("n", "o", api.node.open.edit, opts("Edit"))
        vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Edit"))
      end
  '';
in {
  programs.nvf.settings.vim.filetree.nvimTree = {
    enable = true;
    openOnSetup = false;
    mappings = {
      toggle = "<C-\\>";
      findFile = "<leader>tt";
    };
    setupOpts = {
      # INFO: https://github.com/nvim-tree/nvim-tree.lua?tab=readme-ov-file#custom-mappings
      inherit on_attach;
      actions.open_file.window_picker = {
        enable = true;
        chars = "ARSDHEIQWFPGJLUYOZXCVBKMTN1234567890";
      };
      actions.expand_all.exclude = [
        ".git"
        "target"
        "build"
        "result"
        "node_modules"
        "out"
      ];
      git.enable = true;
      view.width = 35;
      renderer = {
        highlight_git = true;
        icons.show.git = true;

        icons.glyphs.git = {
          unstaged = "";
          untracked = "";
          ignored = "◌";
        };
        indent_markers.enable = true;
        symlink_destination = true;
      };
    };
  };
}
