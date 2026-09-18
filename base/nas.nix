{
  config,
  lib,
  pkgs,
  ...
}:
let
  credential_path = "/etc/.credentials";
  nas_user = config.sops.secrets.nas_user.path;
  nas_password = config.sops.secrets.nas_password.path;
  fsType = "cifs";
  options = [
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
    "credentials=${credential_path}"
    "uid=1000"
    "gid=100"
  ];
in
lib.mkIf config.features.nas.enable {
  systemd.services."nas-credentials" = {
    description = "NAS credentials generation";
    after = [ "multi-user.target" ];
    wantedBy = [ "graphical.target" ];
    wants = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = pkgs.writeShellScript "nas-credentials" ''
        echo -e "username="$(cat ${nas_user})"\npassword="$(cat ${nas_password})"\ndomain=WORKGROUP" | tee ${credential_path}
        chmod 600 ${credential_path}
      '';
    };
  };
  fileSystems =
    let
      addr = config.features.nas.address;
    in
    {
      "/run/mount/nas/music" = {
        device = "//${addr}/music";
        inherit fsType options;
      };
      "/run/mount/nas/db1" = {
        device = "//${addr}/db1";
        inherit fsType options;
      };
    };
}
