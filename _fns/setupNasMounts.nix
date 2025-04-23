{ addr }:
let
  fsType = "cifs";
  options = [
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
    "credentials=/etc/.credentials"
    "uid=1000"
    "gid=100"
  ];
in
{
  fileSystems = {
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
