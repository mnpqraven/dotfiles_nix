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

  # @see helix-editor/helix#14738
  nixpkgs.overlays = [
    (final: prev: {
      typescript-language-server = prev.typescript-language-server.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "typescript-language-server";
          repo = "typescript-language-server";
          rev = "b999e07c8e6bcca53bf1610d3722d2913f515a62";
          hash = "sha256-qKw/AQ6SbodCDJsBJhlHc/w5qFtyhQQv7jFsJiuJtGE=";
        };
      });
    })
  ];

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
