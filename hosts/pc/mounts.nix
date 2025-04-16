{ ... }:
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
  fileSystems."/run/mount/nas/music" = {
    device = "//192.168.1.14/music";
    inherit fsType options;
  };

  fileSystems."/run/mount/nas/db1" = {
    device = "//192.168.1.14/db1";
    inherit fsType options;
  };
}
