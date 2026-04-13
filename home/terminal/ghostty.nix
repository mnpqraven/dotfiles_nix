{
  lib,
  config,
  osConfig,
  ...
}:
lib.mkIf (builtins.elem "ghostty" osConfig.features.terminal.packages) {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    systemd.enable = true;
  };

  # FIXME: dyn
  xdg.configFile.ghostty.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/ghostty";
}
