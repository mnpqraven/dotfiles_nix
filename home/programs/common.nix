{
  osConfig,
  config,
  pkgs,
  ...
}:
let
  cfg = "${osConfig.flake.repoPath}/.config";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages =
    with pkgs;
    [
      bat
      btop
      erdtree
      eza
      fd
      feh
      fzf
      grimblast
      kalker
      keychain
      macchina
      ripgrep
      wl-clipboard
      tofi
      ripdrag
      unrar
      unzip
    ]
    ++ lib.optionals osConfig.features.tools.torrent.enable [
      deluge
    ]
    ++ lib.optionals osConfig.features.tools.discord.enable [
      vesktop
    ]
    ++ lib.optionals osConfig.features.tools.obs.enable [
      obs-studio
    ];
  xdg.configFile = {
    macchina.source = symlink "${cfg}/macchina";
    tofi.source = symlink "${cfg}/tofi";
    btop.source = symlink "${cfg}/btop";
  };
}
