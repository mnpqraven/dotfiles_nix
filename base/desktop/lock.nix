{
  pkgs,
  config,
  ...
}:
let
  displayManager =
    if config.features.kde.enable then
      {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      }
    else
      {
        # plain and simple tty, sddm without kde still breaks kb and mouse
        # see https://github.com/NixOS/nixpkgs/issues/302059
        ly.enable = true;
      };
in
{
  services = { inherit displayManager; };

  services.hypridle.enable = true;
  # hyprlock
  programs.hyprlock.enable = true;
  security.pam.services.hyprlock = { };

  environment.systemPackages = with pkgs; [
    hyprpolkitagent
  ];
}
