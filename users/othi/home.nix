{ pkgs, ... }:
let
  username = "othi";
in
{
  imports = [
    ../../home
  ];

  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };

  # user profile for lockscreens
  home.file.".face.icon" = {
    source = ../../assets/avatar.png;
  };

  # FIXME: home folder ?
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-unikey
    ];
  };
  nixpkgs.config.allowUnfree = true;
}
