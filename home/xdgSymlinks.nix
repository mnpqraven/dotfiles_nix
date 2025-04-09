{config, ...}: let
  cfg = "${config.home.homeDirectory}/dotfiles_nix/.config";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in {
  xdg.configFile = {
    helix.source = symlink "${cfg}/helix";
    hypr.source = symlink "${cfg}/hypr";
    macchina.source = symlink "${cfg}/macchina";
    "starship.toml".source = symlink "${cfg}/starship.toml";
    tofi.source = symlink "${cfg}/tofi";
    zellij.source = symlink "${cfg}/zellij";
  };
}
