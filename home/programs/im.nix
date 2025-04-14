{ inputs, ... }:
{
  # TODO: https://github.com/mnpqraven/dotfiles_nix/issues/50
  home.file = {
    ".config/fcitx5" = {
      source = "${inputs.rootPath}/.config/fcitx5";
      recursive = true;
      force = true;
    };
  };
}
