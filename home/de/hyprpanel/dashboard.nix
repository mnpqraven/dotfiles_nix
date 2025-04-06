_: {

  programs.hyprpanel.settings = {
    # menus.dashboard.powermenu.avatar.image = "~/.hyprpanel/assets/avatar.jpg";
    menus.dashboard = {
      powermenu.avatar.image = "~/.face.icon";
      directories.enabled = false;
      stats.enable_gpu = true;
      shortcuts.left.shortcut1 = {
        command = "librewolf";
        icon = "";
        tooltip = "Librewolf";
      };
    };
  };
}
