{ config, pkgs, lib, ... }:

let
  mod = "Mod1";
in {
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = mod;

      fonts = {
        names = [ "DejaVu Sans Mono" ];
        size = 8.0;
      };

      terminal = "ghostty";

      keybindings = lib.mkOptionDefault {
        # Audio
        "XF86AudioRaiseVolume" = "exec --no-startup-id amixer set Master 10%+";
        "XF86AudioLowerVolume" = "exec --no-startup-id amixer set Master 10%-";
        "XF86AudioMute" = "exec --no-startup-id pactl set Master toggle";

        # Brightness
        "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 5%-";

        # Screenshot
        "Print" = "exec flameshot gui";

        # Launch
        "${mod}+Return" = "exec ghostty";
        "${mod}+q" = "kill";
        "${mod}+d" = "exec --no-startup-id rofi -show drun";
        "${mod}+Shift+q" = "exec --no-startup-id rofi -show power-menu -modi power-menu:rofi-power-menu";
        "${mod}+Shift+p" = "exec --no-startup-id rofi -modi emoji -show emoji";

        # Focus (vim-style)
        "${mod}+j" = "focus left";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus up";
        "${mod}+semicolon" = "focus right";

        # Move windows
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # Layout
        "${mod}+h" = "split h";
        "${mod}+v" = "split v";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+a" = "focus parent";

        # Reload/restart
        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+e" = ''exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"'';

        # Resize mode
        "${mod}+r" = "mode resize";
      };

      modes = {
        resize = {
          "j" = "resize shrink width 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize shrink height 10 px or 10 ppt";
          "semicolon" = "resize grow width 10 px or 10 ppt";
          "Left" = "resize shrink width 10 px or 10 ppt";
          "Down" = "resize grow height 10 px or 10 ppt";
          "Up" = "resize shrink height 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";
          "Return" = "mode default";
          "Escape" = "mode default";
          "${mod}+r" = "mode default";
        };
      };

      bars = [
        {
          fonts = {
            names = [ "DejaVu Sans Mono" "FontAwesome" ];
            size = 10.0;
          };
          statusCommand = "i3status-rs";
          trayOutput = "HDMI-1";
        }
      ];

      floating.modifier = mod;

      window = {
        border = 0;
        titlebar = false;
      };

      floating.border = 0;
      floating.titlebar = false;

      assigns = { };

      workspaceOutputAssign = [
        { workspace = "1"; output = "HDMI-1"; }
        { workspace = "2"; output = "HDMI-1"; }
        { workspace = "3"; output = "eDP-1"; }
        { workspace = "4"; output = "eDP-1"; }
        { workspace = "5"; output = "HDMI-1"; }
      ];

      startup = [
        { command = "dex --autostart --environment i3"; notification = false; }
        { command = "xautolock -time 30000000 -locker 'i3lock -i $HOME/Pictures/disco.png --nofork'"; notification = false; }
        { command = "nm-applet"; notification = false; }
        { command = "autorandr --change"; notification = false; }
        { command = "gammastep"; notification = false; }
        { command = "/usr/bin/lxpolkit"; notification = false; }
        { command = "feh --bg-scale ~/Pictures/revachol.jpg"; notification = false; }
        { command = "kbdd"; notification = false; }
        { command = "setxkbmap -model pc105 -layout us,tr -variant ,, -option grp:caps_toggle"; notification = false; }
        { command = "screenkey --start-disabled"; notification = false; }
        { command = "blueman-applet"; notification = false; }
        { command = "demergi"; notification = false; }
        { command = "1pass"; notification = false; }
        { command = ''i3-msg "workspace 1; exec ghostty"''; notification = false; }
        { command = ''i3-msg "workspace 3; exec slack"''; notification = false; }
        { command = "i3-msg workspace 1"; notification = false; }
      ];
    };

    extraConfig = ''
      for_window [class="zoom"] floating enable
      for_window [class="Clockify"] floating enable
    '';
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        icons = "material-nf";
        theme = "space-villain";
        settings.icons_format = "{icon}";
        blocks = [
          {
            block = "focused_window";
            format = " $title.str(max_w:30) |";
          }
          {
            block = "music";
            format = " $icon {$combo.str(max_w:20,rot_interval:0.5) $play $next |}";
            interface_name_exclude = [ ".*kdeconnect.*" "mpd" ];
          }
          {
            block = "disk_space";
            path = "/";
            info_type = "available";
            alert_unit = "GB";
            interval = 20;
            warning = 20.0;
            alert = 10.0;
            format = " $icon root: $available.eng(w:2) ";
          }
          {
            block = "docker";
            interval = 2;
            format = " $icon $running/$total ";
          }
          {
            block = "sound";
            click = [{ button = "left"; cmd = "pavucontrol"; }];
          }
          {
            block = "backlight";
            device = "intel_backlight";
          }
          {
            block = "hueshift";
            hue_shifter = "gammastep";
            step = 50;
            click_temp = 3500;
          }
          {
            block = "battery";
            format = " $percentage {$time |}";
            device = "DisplayDevice";
            full_format = " FULL ";
            driver = "upower";
          }
          {
            block = "time";
            interval = 10;
            format = " $timestamp.datetime(f:'%a %d/%m/%y %R') ";
          }
          {
            block = "keyboard_layout";
            driver = "kbddbus";
            mappings = {
              "English (US)" = "US";
              "Turkish (N/A)" = "TR";
            };
          }
        ];
      };
    };
  };
}
