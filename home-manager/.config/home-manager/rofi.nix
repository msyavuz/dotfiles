{ config, pkgs, ... }: {
  programs.rofi = {
    enable = true;
    font = "NotoSans Nerd Font";
    extraConfig = {
      icon-theme = "Papirus-Dark";
      show-icons = true;
      terminal = "ghostty";
      drun-display-format = "{icon}{name}";
      disable-history = false;
      sidebar-mode = false;

      kb-row-up = "Up,Control+k";
      kb-row-left = "Left,Control+h";
      kb-row-right = "Right,Control+l";
      kb-row-down = "Down,Control+j";

      kb-accept-entry = "Control+z,Control+y,Return,KP_Enter";

      kb-remove-to-eol = "";
      kb-move-char-back = "Control+b";
      kb-remove-char-back = "BackSpace";
      kb-move-char-forward = "Control+f";
      kb-mode-complete = "Control+o";
    };
    theme = let inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        bg = mkLiteral "#24283b";
        hv = mkLiteral "#9274ca";
        primary = mkLiteral "#C5C8C6";
        ug = mkLiteral "#0B2447";
        font = "Monospace 11";
        border = 0;
        kl = mkLiteral "#7aa2f7";
        black = mkLiteral "#000000";
        transparent-bg = mkLiteral "rgba(36,40,59,0.5)";
        transparent = mkLiteral "rgba(46,52,64,0)";
        background-color = mkLiteral "@transparent";
      };

      "window" = {
        width = 700;
        orientation = mkLiteral "horizontal";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        transparency = "screenshot";
        border-color = mkLiteral "@transparent";
        border = 0;
        border-radius = 6;
        spacing = 0;
        children = map mkLiteral [ "mainbox" ];
        background-color = mkLiteral "rgba(36,40,59,0.75)";
      };

      "mainbox" = {
        spacing = 0;
        children = map mkLiteral [ "inputbar" "message" "listview" ];
        background-color = mkLiteral "transparent";
      };

      "inputbar" = {
        color = mkLiteral "@kl";
        padding = 11;
        border = mkLiteral "0px 0px 0px 0px";
        border-color = mkLiteral "@primary";
        border-radius = mkLiteral "6px 6px 0px 0px";
        background-color = mkLiteral "transparent";
      };

      "message" = {
        padding = 0;
        border = mkLiteral "0px 0px 0px 0px";
        border-color = mkLiteral "@primary";
      };

      "entry" = {
        text-font = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "pointer";
      };

      "prompt" = {
        text-font = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        margin = mkLiteral "0px 5px 0px 0px";
      };

      "case-indicator" = {
        text-font = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "listview" = {
        layout = mkLiteral "vertical";
        padding = 8;
        lines = 12;
        columns = 1;
        border = mkLiteral "0px 0px 0px 0px";
        border-radius = mkLiteral "0px 0px 6px 6px";
        border-color = mkLiteral "@primary";
        dynamic = false;
        background-color = mkLiteral "transparent";
      };

      "element" = {
        padding = 2;
        vertical-align = 1;
        color = mkLiteral "@kl";
        font = mkLiteral "inherit";
        background-color = mkLiteral "transparent";
      };

      "element-text" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "element selected.normal" = {
        color = mkLiteral "@black";
        background-color = mkLiteral "@hv";
      };

      "element normal.active" = {
        color = mkLiteral "@black";
        background-color = mkLiteral "@hv";
      };

      "element normal.urgent" = { background-color = mkLiteral "@primary"; };

      "element selected.active" = {
        background-color = mkLiteral "@hv";
        foreground = mkLiteral "@bg";
      };

      "button" = {
        padding = 6;
        color = mkLiteral "@primary";
        horizontal-align = "0.5";
        border = mkLiteral "2px 0px 2px 2px";
        border-radius = mkLiteral "4px 0px 0px 4px";
        border-color = mkLiteral "@primary";
      };

      "button selected.normal" = {
        border = mkLiteral "2px 0px 2px 2px";
        border-color = mkLiteral "@primary";
      };

      "scrollbar" = { enabled = true; };
    };
  };
}
