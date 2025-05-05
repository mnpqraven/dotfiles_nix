_: {
  # TODO: https://github.com/mnpqraven/dotfiles_nix/issues/50
  home.file.".config/fcitx5" = {
    source = ../../.config/fcitx5;
    recursive = true;
    force = true;
  };
}
