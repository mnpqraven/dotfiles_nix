{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    rmpc
  ];
  xdg.configFile.rmpc.source = config.lib.file.mkOutOfStoreSymlink ../../../.config/rmpc;
}
