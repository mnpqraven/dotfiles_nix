{
  lib,
  pkgs,
  ...
}: let
  # wrap a package for ime compability
  imeWrap = {name}:
    pkgs.symlinkJoin {
      inherit name;
      paths = [pkgs.${name}];
      buildInputs = [pkgs.makeWrapper];
      postBuild = lib.strings.concatStrings [
        "wrapProgram $out/bin/"
        name
        " --add-flags \"--enable-wayland-ime\""
      ];
    };

  teams-for-linux = imeWrap {name = "teams-for-linux";};
  discord = imeWrap {name = "discord";};
in {
  home.packages = with pkgs; [
    bacon
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
    gcc
    go
    hyprshot
    imagemagick
    kalker
    keychain
    librewolf
    macchina
    nodejs_20
    pnpm
    protobuf
    ripgrep
    rustup
    teams-for-linux
    wl-clipboard
    wofi
    tofi
    zellij
  ];
}
