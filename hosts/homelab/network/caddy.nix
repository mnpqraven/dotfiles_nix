# reverse proxy
{
  lib,
  pkgs,
  config,
  ...
}:
let
  caddy = pkgs.caddy.withPlugins {
    plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
    hash = "sha256-dQvk6ezY6TQ1J7PjhCXnThF/SqVgPwBO8/RXzHCY+js=";
  };
in
{
  # www -> othi.dev -> diff container
  #     A <- CF     B <- caddy

  # debug cli
  environment.systemPackages = [ caddy ];

  # https://wiki.nixos.org/wiki/Caddy
  services.caddy = {
    enable = true;
    package = caddy;
    openFirewall = true;

    environmentFile = config.sops.secrets.ENV_CADDY.path;
    extraConfig = ''
      (cf) {
        tls {
          dns cloudflare {$CF_API_TOKEN}
        }
      }
    '';

    # still very iffy that everything CNAMEs to homelab tailnet so if that is
    # unreachable then the whole network is down
    virtualHosts = {
      "health.hl.othi.dev".extraConfig = ''
        respond "OK!"
        import cf
      '';
      "blog.hl.othi.dev".extraConfig = ''
        reverse_proxy http://localhost:5010
        import cf
      '';
      "syncthing.hl.othi.dev".extraConfig = ''
        reverse_proxy http://localhost:8384 {
          header_up +Host localhost
        }
        import cf
      '';
      "torrent.hl.othi.dev" = {
        extraConfig = ''
          reverse_proxy http://localhost:8112
        '';
        useACMEHost = "othi.dev";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  # Allow the Caddy user(and service) to edit certs
  services.tailscale.permitCertUid = "caddy";
}
