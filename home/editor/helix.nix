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

  nixpkgs.overlays = [
    (final: prev: {
      typescript-language-server = prev.typescript-language-server.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "typescript-language-server";
          repo = "typescript-language-server";
          rev = "3e9620951eb79f741e22131670192282baff240c";
          hash = "sha256-wYpW/HHuMetxnwEgGeQ8ptT6Kd5wp2kqUXnjWSkoDQY=";
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
