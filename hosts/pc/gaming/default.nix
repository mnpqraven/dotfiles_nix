# see https://github.com/kronflux/nixos-gaming for some example snippets
{ ... }: {
  imports = [
    ./boot.nix
    ./driver.nix
    ./programs.nix
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    LIBVA_DRIVER_NAME = "nvidia";
  };
}
