{ ... }:
{
  systemd.mounts."nasmusic" = {
    what = "//192.168.1.14/music";
    where = "/media/nas/music";
    type = "cifs";
    options = "nobrl,_netdev,credentials=/etc/.credentials,uid=1000,gid=1000,users,rw";
  };
}
