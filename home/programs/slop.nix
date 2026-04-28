{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.mkIf osConfig.features.slop.enable {
  home.packages = with pkgs; [ claude-code ];
}
