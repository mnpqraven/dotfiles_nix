{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (inputs) username nvf;
  DHOME = inputs.rootPath;
in {
  imports = [
    ../../home

    nvf.homeManagerModules.default
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
  };

  # FIXME: home folder ?
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-unikey
    ];
  };
}
