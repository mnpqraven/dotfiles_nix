{
  config,
  pkgs,
  ...
}: let
  cfgPath = "${config.home.homeDirectory}/dotfiles_nix/.config/helix";
in {
  xdg.configFile."helix".source = config.lib.file.mkOutOfStoreSymlink cfgPath;

  home.packages = with pkgs; [
    # LSPs
    nil
    typescript-language-server
    vscode-langservers-extracted
    lua-language-server

    # formatters
    taplo
    biome
    prettierd
    nixfmt-rfc-style
  ];

  programs.helix = {
    enable = true;
    # languages.language = [
    #   {
    #     name = "rust";
    #     auto-format = true;
    #     formatter.command = "rustfmt";
    #   }
    #   {
    #     name = "nix";
    #     auto-format = true;
    #     formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
    #   }
    # ];
  };
}
