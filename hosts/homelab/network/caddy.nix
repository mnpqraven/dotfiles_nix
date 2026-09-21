# reverse proxy
{ ... }: {
  # www -> othi.dev -> diff container
  #     A <- CF     B <- caddy

  # https://wiki.nixos.org/wiki/Caddy
  services.caddy = {
    enable = true;
    virtualHosts = {
      "localhost".extraConfig = ''
        tls internal
        respond "Hello, world!"
      '';

      # reverse proxy examples
      "example.org".extraConfig = ''
        reverse_proxy http://10.25.40.6
      '';
      "another.example.org".extraConfig = ''
        reverse_proxy unix//run/gunicorn.sock
      '';
    };
  };
}
