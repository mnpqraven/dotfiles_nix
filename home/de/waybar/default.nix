{
  config,
  osConfig,
  pkgs,
  ...
}:
let
  enable =
    if osConfig.features.hyprland.enable then
      osConfig.features.hyprland.bar == "waybar"
    # niri uses waybar
    else
      true;

  sharedBlocks = (import ./modules/shared.nix) { };
in
{
  programs.waybar = {
    inherit enable;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        mode = "dock";
        margin-left = 12;
        margin-right = 12;
        margin-top = 6;
        margin-bottom = 0;
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;
        reload_style_on_change = true;
        # TODO: monitors per device
        # output = [
        #   "eDP-1"
        #   "HDMI-A-1"
        # ];
        modules-left = [
          "custom/padd"
          "custom/terminal"
          "hyprland/workspaces"
          "custom/pad"
          "hyprland/submap"
          "custom/pad"
          "mpd"
        ];
        modules-center = [
          "custom/padd"
          "hyprland/window"
          "custom/padd"
        ];
        modules-right = [
          "group/expandtray"
          "network"
          "group/expand-volume"
          "memory"
          "custom/pad"
          "cpu"
          "custom/pad"
          "custom/cloudflare"
          "clock"
          "group/group-power"
          "custom/padd"
        ];

        # modules
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
        tray = {
          icon-size = 16;
          rotate = 0;
          spacing = 4;
        };
        "group/expandtray" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 200;
            children-class = "not-power";
            # click-to-reveal= true;
            transition-to-left = true;
          };
          modules = [
            "custom/menu"
            "custom/spacer"
            "tray"
          ];
        };

        "custom/menu" = {
          format = "󰅃";
          rotate = 90;
        };
        "hyprland/window" = {
          max-length = 120;
          icon = false;
          icon-size = 13;
        };
        "hyprland/workspaces" = {
          format = "{icon} {name}";
          format-icons = {
            default = "";
            active = "";
          };
        };
        "hyprland/submap" = {
          on-click = "hyprctl dispatch submap reset";
          max-length = 16;
          tooltip = false;
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
        network = {
          tooltip = true;
          format-wifi = "{icon} ";
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

        inherit (sharedBlocks)
          "custom/pad"
          "custom/padd"
          "group/group-power"
          "custom/quit"
          "custom/lock"
          "custom/reboot"
          "custom/power"
          ;

        # "custom/hello-from-waybar" = {
        #   format = "hello {}";
        #   max-length = 40;
        #   interval = "once";
        #   exec = pkgs.writeShellScript "hello-from-waybar" ''
        #     echo "from within waybar"
        #   '';
        # };
      };
    };
  };

  # FIXME: dyn
  # xdg.configFile.waybar.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles_nix/.config/waybar";
}
