_: {
  programs.nvf.settings.vim.keymaps = [
    {
      desc = "Oil panel";
      key = "<leader>tf";
      action = ":Oil --float<CR>";
      mode = ["n"];
    }
  ];
  programs.nvf.settings.vim.utility.oil-nvim = {
    enable = true;
  };
}
