{ pkgs, ... }:
{
  # TODO: feature gate
  # SDDM requires either services.xserver.enable or services.displayManager.sddm.wayland.enable to be true
  services.displayManager.sddm.enable = true;

  services.hypridle.enable = true;
  # hyprlock
  programs.hyprlock.enable = true;
  security.pam.services.hyprlock = { };

  environment.systemPackages = with pkgs; [
    hyprpolkitagent
  ];
}
