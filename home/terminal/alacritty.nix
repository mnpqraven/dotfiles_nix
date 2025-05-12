{ config, ... }:
{
  # TODO: dynamically grab theme from https://github.com/folke/tokyonight.nvim/blob/main/extras/alacritty
  programs.alacritty.enable = true;
  # FIXME: dyn
  xdg.configFile.alacritty.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/alacritty";
}
