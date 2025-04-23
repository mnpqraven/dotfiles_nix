{
  config,
  pkgs,
  inputs,
  ...
}:
{
  programs.helix.enable = true;
  programs.helix.package = inputs.helix.packages."${pkgs.system}".helix;
  xdg.configFile.helix.source = config.lib.file.mkOutOfStoreSymlink ../../.config/helix;

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
