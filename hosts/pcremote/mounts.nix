{ ... }:
let
  fsType = "cifs";
  options = [
    "credentials=/etc/.credentials"
    "rw"
    "x-systemd.automount"
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
