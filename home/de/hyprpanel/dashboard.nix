_: let
  icon = icon: tooltip: command: {
    inherit command icon tooltip;
  };
in {
  programs.hyprpanel.settings = {
    menus.dashboard = {
      powermenu.avatar.image = "~/.face.icon";
      directories.enabled = false;
      stats.enable_gpu = true;
      shortcuts.left = {
        shortcut1 = icon "" "Librewolf" "librewolf";
        shortcut2 = icon "󰊻" "Microsoft Teams" "teams-for-linux";
        shortcut3 = icon "" "Discord" "webcord";
        shortcut4 = icon "" "Syncthing" "librewolf --new-window 127.0.0.1:8384";
      };
    };
  };
}
