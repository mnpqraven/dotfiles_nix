{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
let
  inherit (inputs) nvf;
  username = "othi";
in
{
  imports = [
    ../../home
    nvf.homeManagerModules.default
  ];

  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    sessionVariables = {
      EWW_BIN = "${config.home.homeDirectory}/.nix-profile/bin/eww";
      EWW_CONF = "${config.home.homeDirectory}/.config/eww";
    };
    stateVersion = "24.11";
  };

  # user profile for lockscreens
  home.activation = {
    exportFaceIcon = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      cp ${config.home.homeDirectory}/dotfiles_nix/home/de/hyprpanel_assets/avatar.png ${config.home.homeDirectory}
      mv ${config.home.homeDirectory}/avatar.png ${config.home.homeDirectory}/.face.icon
    '';
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
  nixpkgs.config.allowUnfree = true;
}
