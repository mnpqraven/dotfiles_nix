{
  lib,
  pkgs,
  inputs,
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

  teams-for-linux = imeWrap { name = "teams-for-linux"; };
  discord = imeWrap { name = "discord"; };
in
{
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
    nerdfonts
    pnpm
    protobuf
    ripgrep
    rustup
    teams-for-linux
    wl-clipboard
    wofi
    tofi
    wpaperd
    zellij

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
}
