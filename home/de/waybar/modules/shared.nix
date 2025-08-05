_: {
  "custom/pad" = {
    format = " ";
    interval = "once";
    tooltip = false;
  };
  "custom/padd" = {
    format = "  ";
    interval = "once";
    tooltip = false;
  };
  "group/group-power" = {
    orientation = "inherit";
    drawer = {
      transition-duration = 200;
      children-class = "not-power";
      transition-left-to-right = false;
    };
    modules = [
      "custom/power"
      "custom/quit"
      "custom/lock"
      "custom/reboot"
    ];
  };
  "custom/quit" = {
    format = "󰗼 ";
    tooltip-format = "Log out";
    on-click = "hyprctl dispatch exit";
  };
  "custom/lock" = {
    format = "󰍁 ";
    tooltip-format = "Lock";
    on-click = "hyprlock";
  };
  "custom/reboot" = {
    format = "󰜉 ";
    tooltip = false;
    on-click = "reboot";
  };
  "custom/power" = {
    format = " ";
    tooltip = false;
    on-click = "shutdown now";
  };
  "custom/terminal" = {
    format = " ";
    on-click = "$DEFAULT_TERMINAL";
  };
  "custom/cloudflare" = {
    exec = "$HOME/Scripts/cloudflare_status";
    on-click = "$HOME/Scripts/cloudflare_toggle";
    format = "{icon} {text}";
    interval = 10;
    return-type = "json";
    format-icons = {
      off = "󰦞";
      on = "󰒘";
    };
  };
  memory = {
    interval = 1;
    format = "{icon} {percentage:2}%";
    format-icons = [
      "󰝦"
      "󰪞"
      "󰪟"
      "󰪠"
      "󰪡"
      "󰪢"
      "󰪣"
      "󰪤"
      "󰪥"
    ];
    max-length = 10;
  };
  cpu = {
    interval = 1;
    format = "{icon} {usage:2}%";
    tooltip = false;
    format-icons = [
      "󰝦"
      "󰪞"
      "󰪟"
      "󰪠"
      "󰪡"
      "󰪢"
      "󰪣"
      "󰪤"
      "󰪥"
    ];
  };
  mpd = {
    format = "{albumArtist} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S})";
    format-disconnected = "";
    format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
    interval = 10;
    consume-icons = {
      on = " "; # Icon shows only when "consume" is on
    };
    random-icons = {
      off = ""; # Icon grayed out when "random" is off
      on = " ";
    };
    repeat-icons = {
      "on" = " ";
    };
    single-icons = {
      "on" = " 1 ";
    };
    state-icons = {
      paused = "";
      playing = "";
    };
    tooltip = false;
  };
  "group/expand-tray" = {
    orientation = "horizontal";
    drawer = {
      transition-duration = 200;
      children-class = "not-power";
      # click-to-reveal= true;
      transition-to-left = true;
    };
    modules = [
      "custom/expand-left"
      "tray"
    ];
  };
  "custom/expand-left" = {
    format = "󰅃";
    rotate = 90;
  };
  tray = {
    icon-size = 16;
    rotate = 0;
    spacing = 4;
  };
  network = {
    tooltip = true;
    format-wifi = "{icon}  ";
    format-icons = [
      "󰤟"
      "󰤥"
      "󰤨"
    ];
    rotate = 0;
    format-ethernet = "󰈀 ";
    tooltip-format = "Up= {bandwidthTotalBits} \nDown= {bandwidthDownBits}";
    format-linked = "󰈀 {ifname} (No IP)";
    format-disconnected = "󰈂 ";
    tooltip-format-disconnected = "Disconnected";
    interval = 2;
  };
  "group/expand-volume" = {
    orientation = "horizontal";
    drawer = {
      transition-duration = 600;
      children-class = "not-power";
      transition-to-left = true;
      click-to-reveal = true;
    };
    modules = [
      "pulseaudio"
      "pulseaudio/slider"
    ];
  };
  pulseaudio = {
    format = "{icon} {volume}% ";
    rotate = 0;
    format-muted = "";
    tooltip-format = "{icon}  {desc} | {volume}%";
    scroll-step = 5;
    format-icons = {
      headphone = "";
      hands-free = "";
      headset = "";
      phone = "";
      portable = "";
      car = "";
      default = [
        ""
        ""
        ""
      ];
    };
  };
  "pulseaudio/slider" = {
    min = 5;
    max = 100;
    rotate = 0;
    device = "pulseaudio";
    scroll-step = 1;
  };
}
