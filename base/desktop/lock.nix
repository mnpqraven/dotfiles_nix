{
  pkgs,
  config,
  ...
}:
{
  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = config.features.wayland.enable;
      };
      defaultSession = if config.features.desktops.niri.enable then "niri" else null;
    };
  };

  services.hypridle.enable = true;
  # hyprlock
  programs.hyprlock.enable = true;
  security.pam.services.hyprlock = { };

  environment.systemPackages = with pkgs; [
    hyprpolkitagent
  ];
}
