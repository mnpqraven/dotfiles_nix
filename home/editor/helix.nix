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
  programs.helix.package = inputs.helix.packages."${pkgs.system}".helix;
  # FIXME: dyn
  xdg.configFile.helix.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/helix";

  home.packages = with pkgs; [
    # nix
    nil
    nixfmt-rfc-style

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
