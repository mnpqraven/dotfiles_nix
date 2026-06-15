{
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.optionalAttrs builtins.elem "librewolf" osConfig.features.webBrowser.browsers {
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
