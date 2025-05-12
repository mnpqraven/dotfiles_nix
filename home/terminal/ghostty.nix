{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    ghostty
  ];

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
  };
  # FIXME: dyn
  xdg.configFile.ghostty.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/ghostty";
}
