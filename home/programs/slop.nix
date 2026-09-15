{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.mkIf osConfig.features.tools.slop.enable {
  home.packages = with pkgs; [ claude-code ];
}
