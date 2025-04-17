{
  lib,
  pkgs,
  config,
  ...
}:
let
  # wrap a package for ime compability
  imeWrap =
    { name }:
    pkgs.symlinkJoin {
      inherit name;
      paths = [ pkgs.${name} ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = lib.strings.concatStrings [
        "wrapProgram $out/bin/"
        name
        " --add-flags \"--enable-wayland-ime\""
      ];
    };
  cfg = "${config.home.homeDirectory}/dotfiles_nix/.config";
  symlink = config.lib.file.mkOutOfStoreSymlink;

  teams-for-linux = imeWrap { name = "teams-for-linux"; };
  discord = imeWrap { name = "webcord"; };
in
{
  home.packages = with pkgs; [
    bat
    brave
    btop
    deluge
    discord
    eww
    eza
    fd
    feh
    fzf
    hyprshot
    imagemagick
    kalker
    keychain
    librewolf
    macchina
    obs-studio
    ripgrep
    teams-for-linux
    wl-clipboard
    tofi
    zellij
  ];
  xdg.configFile = {
    macchina.source = symlink "${cfg}/macchina";
    tofi.source = symlink "${cfg}/tofi";
    zellij.source = symlink "${cfg}/zellij";
  };
}
