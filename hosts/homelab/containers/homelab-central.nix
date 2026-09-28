{ inputs, pkgs, ... }:
let
  package = inputs.othi-hc.packages.${pkgs.stdenv.hostPlatform.system}.othi-hc;

  pname = "othi-hc";
in
{
  systemd.services.homelab-central = {
    description = "Othi's homelab";
    startLimitIntervalSec = 0;
    after = [ "multi-user.target" ];
    wantedBy = [ "graphical.target" ];
    wants = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${package}/bin/${pname}";
    };
    environment = {
      PORT = "5000";
    };
  };
}
