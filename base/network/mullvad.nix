{
  lib,
  config,
  pkgs,
  ...
}:
let
  mullvad = config.services.mullvad-vpn.package;
  bin = "${mullvad}/bin/mullvad";
  # TODO: login cond.
  account = config.sops.secrets.mullvad_account_number.path;

in
lib.mkIf config.features.services.vpn.enable {
  services.mullvad-vpn = {
    enable = true;
    gui.enable = config.features.services.vpn.gui.enable;
  };

  # @see https://discourse.nixos.org/t/connected-to-mullvadvpn-but-no-internet-connection/35803
  services.resolved.enable = true;
  systemd.services."mullvad-daemon" = {
    # TODO: connect if account get is null
    postStart = ''
      sleep 1
      ${bin} lan set allow
      ${bin} lockdown-mode set off # we don't need lockdown yet until ssh config is finished
      ${bin} tunnel set quantum-resistant on
      ${bin} tunnel set daita on
      ${bin} tunnel set daita-direct-only on
      ${bin} relay set location sg
      sleep 1
      ${bin} connect
    '';
  };

  networking.nftables = {
    enable = true;
    # ssh through vpn
    # connection tracking mark (0x00000f41) to get through the firewall
    # and a meta mark (0x6d6f6c65) to route the traffic outside the tunnel
    # @see https://wiki.nftables.org/wiki-nftables/index.php/Setting_packet_metainformation#packet_mark_and_conntrack_mark
    ruleset = ''
      table inet excludeTraffic {
        chain allowIncoming {
          type filter hook input priority -100; policy accept;
          tcp dport 22 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }
        chain allowOutgoing {
          type route hook output priority -100; policy accept;
          tcp sport 22 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }
      }
    '';
  };
}
