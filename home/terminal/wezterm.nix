{
  lib,
  config,
  osConfig,
  ...
}:
lib.mkIf (builtins.elem "wezterm" osConfig.features.terminal.packages) {
  programs.wezterm.enable = true;

  xdg.configFile.wezterm.source = config.lib.file.mkOutOfStoreSymlink "${osConfig.flake.repoPath}/.config/wezterm";
}
