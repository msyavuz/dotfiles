{ pkgs, ... }:

{
  # Dunst notifications
  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_width = 0;
        corner_radius = 5;
      };
      urgency_low = {
        background = "#1a1b26";
        foreground = "#7aa2f7";
        frame_color = "#7aa2f7";
      };
      urgency_normal = {
        background = "#1a1b26";
        foreground = "#7aa2f7";
        frame_color = "#7aa2f7";
      };
      urgency_critical = {
        background = "#292e42";
        foreground = "#db4b4b";
        frame_color = "#db4b4b";
      };
    };
  };

  # Gammastep
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 48.0;
    longitude = 11.0;
    temperature = {
      day = 3500;
      night = 3500;
    };
    settings.general.fade = 0;
  };

  # Autorandr
  programs.autorandr = {
    enable = true;
    hooks.postswitch = {
      "set-wallpaper" = ''
        ${pkgs.feh}/bin/feh --bg-scale ~/Pictures/revachol.jpg
        gammastep -x
      '';
    };
    profiles = {
      "laptop-only" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff0006afad3c0000000000210104a51e137803cb5591575a91291c505400000001010101010101010101010101010101263d80b870b0284010103e002dbc10000018000000fd00283c4b4b10010a202020202020000000fe0041554f0a202020202020202020000000fe004231343055414e30342e37200a00e8";
        };
        config = {
          HDMI-1.enable = false;
          DP-1.enable = false;
          DP-2.enable = false;
          DP-3.enable = false;
          DP-4.enable = false;
          eDP-1 = {
            enable = true;
            primary = true;
            crtc = 0;
            gamma = "1.0:0.714:0.526";
            mode = "1920x1200";
            position = "0x0";
            rate = "60.00";
          };
        };
      };
      "dual-monitor" = {
        fingerprint = {
          HDMI-1 = "00ffffffffffff004c2ddb7143335834121f0103803c22782af812a8534598231b4f5cbfef80714f810081c081809500a9c0b30001010474801871382d40582c450055502100001e000000fd0032781e871e000a202020202020000000fc004c53323741473332780a202020000000ff0048394a5731303131353520202001d202031cf147903f1f04130312230907078301000067030c001000b83c023a801871382d40582c450055502100001e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000be";
          eDP-1 = "00ffffffffffff0006afad3c0000000000210104a51e137803cb5591575a91291c505400000001010101010101010101010101010101263d80b870b0284010103e002dbc10000018000000fd00283c4b4b10010a202020202020000000fe0041554f0a202020202020202020000000fe004231343055414e30342e37200a00e8";
        };
        config = {
          DP-1.enable = false;
          DP-2.enable = false;
          DP-3.enable = false;
          DP-4.enable = false;
          HDMI-1 = {
            enable = true;
            primary = true;
            crtc = 0;
            gamma = "1.0:0.714:0.526";
            mode = "1920x1080";
            position = "0x0";
            rate = "120.00";
          };
          eDP-1 = {
            enable = true;
            crtc = 1;
            gamma = "1.0:0.714:0.526";
            mode = "1920x1200";
            position = "1920x0";
            rate = "60.00";
          };
        };
      };
    };
  };
}
