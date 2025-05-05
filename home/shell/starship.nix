{ config, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  # FIXME: dyn
  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/starship.toml";
}
