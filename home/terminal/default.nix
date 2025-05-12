{ osConfig, ... }:
{
  imports = [
    ./alacritty.nix
    ./wezterm.nix
    ./ghostty.nix
  ];
  # WARN: needs reboot or relogin to take effects
  home.sessionVariables = {
    TERMINAL = osConfig.features.terminal.default;
  };
}
