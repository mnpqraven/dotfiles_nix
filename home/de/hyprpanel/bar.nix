_: {
  programs.hyprpanel.settings = {
    theme.bar.transparent = false;
    bar = {
      launcher.autoDetectIcon = true;
      workspaces.show_icons = true;
      systray.ignore = ["Fcitx"];
    };
  };
}
