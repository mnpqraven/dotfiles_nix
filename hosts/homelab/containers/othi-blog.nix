{ inputs, pkgs, ... }:
let
  package = inputs.vps.packages.${pkgs.stdenv.hostPlatform.system}.user-root;
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
      ExecStart = "${package}/bin/user-root";
      User = "root";
    };
  };
}
