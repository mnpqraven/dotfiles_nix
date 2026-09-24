# reverse proxy
{
  lib,
  pkgs,
  config,
  ...
}:
{
  # www -> othi.dev -> diff container
  #     A <- CF     B <- caddy

  # https://wiki.nixos.org/wiki/Caddy
  services.caddy = {
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
      hash = "sha256-dQvk6ezY6TQ1J7PjhCXnThF/SqVgPwBO8/RXzHCY+js=";
    };
    environmentFile = config.sops.secrets.ENV_CADDY.path;
    openFirewall = true;
    enable = true;
    extraConfig = ''
      (cloudflare) {
        tls {
          dns cloudflare {env.CF_API_TOKEN}
        }
      }
    '';
    virtualHosts = {
      "othi.dev".extraConfig = ''
        respond "hello world from https othi.dev"
      '';
      "syncthing.hl.othi.dev".extraConfig = ''
        reverse_proxy http://192.168.1.216:8384
        import cloudflare
      '';
      "syncthing_nas.hl.othi.dev".extraConfig = ''
        reverse_proxy http://192.168.1.14:8384
        import cloudflare
      '';
    };
  };
  networking.firewall.allowedTCPPorts = [
    80 # http
    443 # https
  ];
  networking.firewall.logRefusedPackets = true; # debug
}
