{ ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  # ssh through vpn
  # this rule needs to be enabled even if mullvad is not installed
  networking.nftables = {
    enable = true;
    # connection tracking mark (0x00000f41) to get through the firewall
    # and a meta mark (0x6d6f6c65) to route the traffic outside the tunnel
    # @see https://wiki.nftables.org/wiki-nftables/index.php/Setting_packet_metainformation#packet_mark_and_conntrack_mark
    # maybe this is blocking ssh ?
    # ruleset = ''
    #   table inet excludeTraffic {
    #     chain allowIncoming {
    #       type filter hook input priority -100; policy accept;
    #       tcp dport 22 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
    #     }
    #     chain allowOutgoing {
    #       type route hook output priority -100; policy accept;
    #       tcp sport 22 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
    #     }
    #   }
    # '';
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
}
