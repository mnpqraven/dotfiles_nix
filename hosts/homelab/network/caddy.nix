# reverse proxy
{ lib, ... }: {
  # www -> othi.dev -> diff container
  #     A <- CF     B <- caddy

  # https://wiki.nixos.org/wiki/Caddy
  services.caddy = {
    openFirewall = true;
    enable = true;
    virtualHosts = {
      "othi.dev".extraConfig = ''
        respond "hello world from https othi.dev"
      '';
      "othi.local".extraConfig = ''
        respond "hello world from local othi.local"
      '';
      "localhost".extraConfig = ''
        tls internal
        root * /home/othi/dotfiles_nix/hosts/homelab/network/demosite
        file_server {
          hide .git LICENSE
        }
      '';
      "othitest.org".extraConfig = ''
        respond "Hello, world!"
      '';

      # reverse proxy examples
      "example.org".extraConfig = ''
        respond "hello wor"
      '';
      "another.example.org".extraConfig = ''
        reverse_proxy unix//run/gunicorn.sock
      '';
    };
  };
  networking.firewall.allowedTCPPorts = [
    80 # http
    443 # https
  ];
  networking.firewall.logRefusedPackets = true;
}
