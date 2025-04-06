{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  inherit (inputs) username;
  DHOME = inputs.rootPath;
in
{
  imports = [
    ../../home/editor
    ../../home/shell
    ../../home/programs
    ../../home/de/hyprland.nix

    inputs.extraModules.nvf
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    inherit DHOME;
    EWW_BIN = "/home/${username}/.nix-profile/bin/eww";
    EWW_CONF = "${DHOME}/.config/eww";
  };
  home.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;

  programs = {
    home-manager.enable = true;

    # neovim = {
    #   enable = true;
    #   defaultEditor = true;
    #   viAlias = true;
    #   vimAlias = true;
    #   vimdiffAlias = true;
    # };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-unikey
    ];
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # https://home-manager-options.extranix.com/?query=file&release=release-24.11
    ".config/zellij/config.kdl".source = "${DHOME}/.config/zellij/config.kdl";

    ".config/macchina" = {
      source = "${DHOME}/.config/macchina";
      recursive = true;
    };
    # TODO:
    # ".config/fcitx5" = {
    #   source = "${DHOME}/.config/fcitx5";
    #   recursive = true;
    # };
    # ".config/nvim" = {
    #   source = "${DHOME}/.config/nvim";
    #   recursive = true;
    # };
  };
}
