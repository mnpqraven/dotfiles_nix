{
  lib,
  config,
  pkgs,
  ...
}:
let
  mullvad = config.services.mullvad-vpn.package;
  bin = "${mullvad}/bin/mullvad";
  account = config.sops.secrets.mullvad_account_number.path;
in
lib.mkIf config.features.services.vpn.enable {
  services.mullvad-vpn = {
    enable = true;
    gui.enable = config.features.services.vpn.gui.enable;
  };

  # @see https://discourse.nixos.org/t/connected-to-mullvadvpn-but-no-internet-connection/35803
  services.resolved.enable = false;

  systemd.services."mullvad-autostart" = lib.mkIf config.features.services.vpn.autostart {
    description = "Mullvad autostart";
    after = [ "multi-user.target" ];
    wantedBy = [ "graphical.target" ];
    wants = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = pkgs.writeShellScript "mullvad-autostart" ''
        "${bin}" account login "$(cat ${account})" > /dev/null
      '';
    };
    postStart = "${bin} connect";
  };
}
