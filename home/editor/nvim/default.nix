_: {
  imports = [
    ./autocomplete
    ./git.nix
    ./hop.nix
    ./lsp.nix
    ./keys_colemak.nix
    ./mini.nix
    ./opt.nix
    ./telescope.nix
    ./tree.nix
    ./ui.nix
  ];

  programs = {
    neovim.enable = true;
    nvf.enable = true;
  };

  programs.nvf.settings.vim = {
    viAlias = false;
    vimAlias = true;

    globals = {
      mapleader = " ";
    };
    binds.whichKey.enable = true;

    autocmds = [
      {
        enable = true;
        desc = "Trim whitespace";
        command = "%s/\\s\\+$//e";
        event = [ "BufWritePre" ];
      }
    ];
  };
}
