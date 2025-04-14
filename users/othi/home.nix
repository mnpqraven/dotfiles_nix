{
  pkgs,
  inputs,
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

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.sessionVariables = {
    EWW_BIN = "/home/${username}/.nix-profile/bin/eww";
    # FIXME: dyn
    EWW_CONF = "/home/${username}/.config/eww";
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

  home.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;
}
