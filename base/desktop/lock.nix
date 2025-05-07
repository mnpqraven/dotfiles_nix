{ pkgs, ... }:
{
  # TODO: feature gate
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.hypridle.enable = true;
  # hyprlock
  programs.hyprlock.enable = true;
  security.pam.services.hyprlock = { };

  environment.systemPackages = with pkgs; [
    hyprpolkitagent
  ];
}
