{ pkgs, ... }:
{
  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      defaultSession = "niri";
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
