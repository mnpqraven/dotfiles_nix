{ config, inputs, pkgs, ... }: {
  programs = {
    starship.enable = true;
    starship.enableZshIntegration = true;
  };
  home.file.".config/starship.toml".source = ./starship.toml;
}
