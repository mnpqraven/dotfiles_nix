{
  config,
  inputs,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [ zoxide ];
  programs = {
    zoxide.enable = true;
    zoxide.enableZshIntegration = true;
  };
}
