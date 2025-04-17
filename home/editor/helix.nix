{
  config,
  pkgs,
  ...
}:
let
  cfgPath = "${config.home.homeDirectory}/dotfiles_nix/.config/helix";
in
{
  programs.helix.enable = true;
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
}
