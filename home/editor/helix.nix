{
  osConfig,
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
lib.mkIf osConfig.features.editors.helix.enable {
  programs.helix.enable = true;
  programs.helix.package = inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.helix;
  xdg.configFile.helix.source = config.lib.file.mkOutOfStoreSymlink "${osConfig.flake.repoPath}/.config/helix";

  home.packages = with pkgs; [
    # nix
    nil
    nixfmt

    uwu-colors

    # javascript ecosystem
    typescript-language-server
    vscode-langservers-extracted
    biome
    prettierd

    # lua
    lua-language-server

    # yaml
    yaml-language-server

    # toml
    taplo
  ];
}
