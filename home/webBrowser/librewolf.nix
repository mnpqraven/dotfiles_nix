{ osConfig, ... }:
let
  enable = builtins.elem "librewolf" osConfig.features.webBrowser.browsers;
in
{
  programs.librewolf = {
    inherit enable;
    # relax some default settings
    settings = {
      "privacy.resistFingerprinting" = false;
      "webgl.disabled" = false;
      "privacy.clearOnShutdown.history" = false;
      "security.OCSP.require" = false;
    };
  };
}
