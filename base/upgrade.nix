{
  config,
  inputs,
  lib,
  ...
}:
lib.mkIf config.features.autoUpgrade.enable {
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--show-trace"
      "-L"
      "-v"
    ];
    dates = "weekly";
    randomizedDelaySec = "45min";
  };
}
