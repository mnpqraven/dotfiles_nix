# sections of feature flags serialized to JSON so other applications can read
# nixos configs
# NOTE: keep this json compact, not all settings need to be generated,
# just the bare minimum needed by other tools
{ config, osConfig, ... }:
let
  flags = osConfig.features;
  text = builtins.toJSON {
    gaming.enable = flags.gaming.enable;
    kde.enable = flags.kde.enable;
    browser =
      let
        installed = text: builtins.elem text flags.webBrowser.browsers;
      in
      {
        zen.enable = installed "zen";
        helium.enable = installed "helium";
        librewolf.enable = installed "librewolf";
      };
    services = {
      syncthing.enable = flags.syncthing.enable;
    };
    tools = {
      obs = flags.tools.obs;
      discord = flags.tools.discord;
      torrent = flags.tools.torrent;
    };
  };
in
{
  xdg.configFile.jsonConfig = {
    target = "${config.home.homeDirectory}/.config/features-conf/config.json";
    inherit text;
    force = true;
  };
}
