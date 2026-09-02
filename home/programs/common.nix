{
  config,
  pkgs,
  ...
}:
let
  # FIXME: dyn
  cfg = "${config.home.homeDirectory}/dotfiles_nix/.config";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = with pkgs; [
    bat
    btop
    deluge
    vesktop
    erdtree
    eza
    fd
    feh
    fzf
    grimblast
    imagemagick
    kalker
    keychain
    macchina
    obs-studio
    ripgrep
    wl-clipboard
    tofi
    ripdrag
    unrar
    unzip
  ];
  xdg.configFile = {
    macchina.source = symlink "${cfg}/macchina";
    tofi.source = symlink "${cfg}/tofi";
    btop.source = symlink "${cfg}/btop";
  };
}
