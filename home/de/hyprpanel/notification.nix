_: {
  programs = {
    hyprpanel.settings.menus.power = {
      lowBatteryNotification = true;
      lowBatteryThreshold = 15;
    };
    hyprpanel.settings.bar.notifications = {
      hideCountWhenZero = true;
      show_total = true;
    };
    hyprpanel.settings.notifications = {
      active_monitor = false;
      position = "top";
      showActionsOnHover = true;
    };
  };
}
