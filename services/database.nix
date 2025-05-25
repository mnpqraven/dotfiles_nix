{
  lib,
  config,
  pkgs,
  ...
}:
# @see https://nixos.wiki/wiki/PostgreSQL
lib.mkIf config.features.database.enable {
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  addr       auth-method
      local all       all                trust
      host  all       all     ::1/128    trust
    '';
  };
  environment.systemPackages = with pkgs; [
    dbeaver-bin
  ];
}
