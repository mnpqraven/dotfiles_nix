{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.features.development.enable {
  environment.systemPackages = with pkgs; [
    omnisharp-roslyn
    roslyn-ls
    csharp-ls
  ];
}
