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
    # "rw"
  ];
in
{
  # TODO: 99% remote ip doesn't work atm
  fileSystems."/run/mount/nas/music" = {
    device = "//nas.othi.dev/music";
    inherit fsType options;
  };

  fileSystems."/run/mount/nas/db1" = {
    device = "//nas.othi.dev/db1";
    inherit fsType options;
  };
}
