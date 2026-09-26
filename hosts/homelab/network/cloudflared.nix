{ config, ... }:
let
  tunnel = "a14caee3-a645-4753-b21a-d59fc9433f80";
in
{
  sops.secrets = {
    cloudflared_cert = {
      group = "users";
      owner = config.users.users.othi.name;
      mode = "0400";
    };
    "cloudflared_conf_${tunnel}" = {
      group = "users";
      owner = config.users.users.othi.name;
      mode = "0400";
    };
  };

  services.cloudflared = {
    enable = true;
    tunnels = {
      ${tunnel} = {
        credentialsFile = config.sops.secrets."cloudflared_conf_${tunnel}".path;
        default = "http_status:404";
        ingress."othi.dev" = "http://localhost:5010";
      };
    };
  };

  networking = {
    firewall = {
      allowedUDPPorts = [ 7844 ];
      allowedTCPPorts = [ 7844 ];
    };
    # Allow cloudflared to work around mullvad
    # unclear on why this is only required now....
    # https://developers.cloudflare.com/tunnel/configuration/
    # prio needs to be -100
    nftables.tables.mullvad_cloudflared = {
      family = "inet";
      content = ''
        chain output {
          type route hook output priority -100; policy accept;
          udp dport 7844 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
          tcp dport 7844 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }
      '';
    };
  };
}
