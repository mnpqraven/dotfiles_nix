{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    clifm
  ];
  xdg.configFile.clifm.source = config.lib.file.mkOutOfStoreSymlink ../../../.config/clifm;
}
