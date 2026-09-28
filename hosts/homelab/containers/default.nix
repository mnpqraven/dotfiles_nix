{ ... }: {
  imports = [
    ./calibre.nix
    ./ddns-cron.nix
    ./torrent.nix

    ./homelab-central.nix
    ./othi-blog.nix
    ./vps-api.nix
    ./vps-rpc.nix
  ];
}
