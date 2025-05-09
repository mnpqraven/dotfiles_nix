{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.features.network.cloudflare.enable {
  environment.systemPackages = with pkgs; [ cloudflare-warp ];
  systemd.packages = with pkgs; [ cloudflare-warp ];
  # causes warp-svc to be started automatically
  systemd.targets.multi-user.wants = [ "warp-svc.service" ];
}
