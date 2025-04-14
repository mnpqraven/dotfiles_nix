_: {
  programs.nvf.settings.vim = {
    utility.motion.hop = {
      enable = true;
    };

    extraPlugins."hop-nvim" = {
      package = "hop-nvim";
      setup = ''
        require('hop').setup{
         keys = "arsdheiqwfpgjluyozxcvbkmtn";
        }
      '';
    };

    keymaps = [
      {
        key = "<leader>h";
        action = "<cmd>HopWord<CR>";
        mode = [ "n" ];
        desc = "Hop";
      }
    ];
  };
}
