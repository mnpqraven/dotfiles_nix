{ inputs, ... }: {
  imports = [ ./colemak.nix ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;

        lsp.enable = true;
      };
    };
  };
}
