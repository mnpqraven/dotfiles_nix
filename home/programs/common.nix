{
  config,
  lib,
  pkgs,
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
        # NOTE: needed for niri
        # probably need to deal with this sooner or later
        " --add-flags \"--ozone-platform=x11\""
      ];
    };

  # FIXME: dyn
  cfg = "${config.home.homeDirectory}/dotfiles_nix/.config";
  symlink = config.lib.file.mkOutOfStoreSymlink;

  teams-for-linux = imeWrap { name = "teams-for-linux"; };
  discord = imeWrap { name = "webcord"; };
in
{
  home.packages = with pkgs; [
    bat
    btop
    deluge
    discord
    erdtree
    eza
    fd
    feh
    fzf
    grimblast
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
    ripdrag
  ];
  xdg.configFile = {
    macchina.source = symlink "${cfg}/macchina";
    tofi.source = symlink "${cfg}/tofi";
    btop.source = symlink "${cfg}/btop";
  };
}
