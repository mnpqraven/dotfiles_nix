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
  services.resolved.enable = true;

  systemd.services."mullvad-daemon" = {
    # TODO: connect if account get is null
    postStart = ''
      ${bin} lan set allow
      ${bin} lockdown-mode set on
      ${bin} tunnel set quantum-resistant on
      ${bin} tunnel set daita on
      ${bin} tunnel set daita-direct-only on
      ${bin} relay set location sg
      ${bin} connect
    '';
  };

  # systemd.services."mullvad-autostart" = lib.mkIf config.features.services.vpn.autostart {
  #   description = "Mullvad autostart";
  #   requires = [ "mullvad-daemon.service" ];
  #   after = [ "mullvad-daemon.service" ];
  #   wantedBy = [ "graphical.target" ];
  #   serviceConfig = {
  #     Type = "simple";
  #     Restart = "on-failure";
  #     RestartSec = 5;
  #     StartLimitBurst = 5;
  #     StartLimitIntervalSec = 60;
  #     ExecStart = pkgs.writeShellScript "mullvad-autostart" ''
  #       "${bin}" account login "$(cat ${account})" > /dev/null
  #     '';
  #   };
  #   postStart = ''
  #     ${bin} lan set allow
  #     ${bin} lockdown-mode set on
  #     ${bin} tunnel set quantum-resistant on
  #     ${bin} tunnel set daita on
  #     ${bin} tunnel set daita-direct-only on
  #     ${bin} relay set location sg
  #     ${bin} connect
  #   '';
  # };
}
