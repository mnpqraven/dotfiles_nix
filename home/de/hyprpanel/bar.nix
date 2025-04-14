_: {
  programs.hyprpanel.settings.bar = {
    launcher.autoDetectIcon = true;
    workspaces.show_icons = false;
    workspaces.show_numbered = true;
    systray.ignore = [ "Fcitx" ];
    customModules.netstat.dynamicIcon = true;
    network.truncation = false;
    autoHide = "fullscreen";
    battery.hideLabelWhenFull = true;
  };
}
