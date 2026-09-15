{ config, ... }:
{
  programs.nh = {
    enable = true;
    flake = config.flake.repoPath;
    clean = {
      enable = true;
      extraArgs = "--keep 3 --keep-since 7d";
    };
  };
}
