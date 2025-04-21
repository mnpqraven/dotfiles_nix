{
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

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    sessionVariables = {
      EWW_BIN = "${config.home.homeDirectory}/.nix-profile/bin/eww";
      EWW_CONF = "${config.home.homeDirectory}/.config/eww";
    };
    stateVersion = "24.11";
  };
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
  nixpkgs.config.allowUnfree = true;
}
