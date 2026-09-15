{ config, osConfig, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${osConfig.flake.repoPath}/.config/starship.toml";
}
