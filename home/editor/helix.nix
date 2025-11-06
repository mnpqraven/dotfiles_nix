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
        patches = (old.patches or [ ]) ++ [
          (prev.fetchpatch {
            url = "https://github.com/computerdane/typescript-language-server/commit/dddbd320977e9c26aa0d854e77f5a6cd1b20c5f1.patch";
            hash = "sha256-skj+877Z01RSmapjbN7PUO+ONl6/yaBT/r4LnUznbJI=";
          })
        ];
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
