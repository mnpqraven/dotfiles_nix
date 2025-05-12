{ osConfig, ... }:
{
  imports = [
    ./alacritty.nix
    ./wezterm.nix
    ./ghostty.nix
  ];
  # WARN: needs reboot or relogin to take effects
  home.sessionVariables = {
    # BUG: if we launch a non-default terminal (e.g. with tofi) then we get a
    # terminal mismatch between the env and the actual running terminal
    DEFAULT_TERMINAL = osConfig.features.terminal.default;
  };
}
