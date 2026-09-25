{ inputs, pkgs, ... }:
let
  package = inputs.vps.packages.${pkgs.stdenv.hostPlatform.system}.user-root;
  name = "user-root";
in
{
  systemd.services.othi-blog = {
    description = "Othi's webpage";
    startLimitIntervalSec = 0;
    after = [ "multi-user.target" ];
    wantedBy = [ "graphical.target" ];
    wants = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${package}/bin/${name}";
    };
    environment = {
      LEPTOS_SITE_ADDR = "127.0.0.1:5010";
      LEPTOS_SITE_ROOT = "${package}/bin/site";
      LEPTOS_OUTPUT_NAME = name;
    };
  };
}
