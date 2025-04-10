_: {
  programs.nvf.settings.vim.git = {
    enable = true;
    gitsigns.enable = false;
  };
  programs.nvf.settings.vim.keymaps = [
    {
      desc = "Git panel";
      key = "<leader>gg";
      action = ":G<CR>";
      mode = ["n"];
    }
  ];
}
