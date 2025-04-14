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
  fileSystems."/run/mount/nas/music" = {
    device = "//192.168.1.14/music";
    inherit fsType options;
  };

  fileSystems."/run/mount/nas/db1" = {
    device = "//192.168.1.14/db1";
    inherit fsType options;
  };
}
