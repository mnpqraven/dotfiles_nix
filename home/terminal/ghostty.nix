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

  xdg.configFile.ghostty.source = config.lib.file.mkOutOfStoreSymlink "${osConfig.flake.repoPath}/.config/ghostty";
}
