{ pkgs, ... }: {
  services.polybar = {
    enable = false; # Disable service, we will launch manually from i3
    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };
    script = ''
      LOGFILE="/tmp/polybar.log"
      XRANDR="${pkgs.xorg.xrandr}/bin/xrandr"
      export DISPLAY=:0
      export XAUTHORITY=$HOME/.Xauthority
      
      echo "--- Polybar Launch $(date) ---" > "$LOGFILE"
      echo "DISPLAY=$DISPLAY" >> "$LOGFILE"
      
      if [ -x "$XRANDR" ]; then
        echo "xrandr found, querying..." >> "$LOGFILE"
        MONITORS=$($XRANDR --query | grep " connected" | cut -d" " -f1)
        echo "Monitors found: $MONITORS" >> "$LOGFILE"
        
        for m in $MONITORS; do
          echo "Starting on $m" >> "$LOGFILE"
          MONITOR=$m polybar --reload main >> "$LOGFILE" 2>&1 &
        done
      else
        polybar --reload main >> "$LOGFILE" 2>&1 &
      fi
    '';
    config = {
      "bar/main" = {
        monitor = "\${env:MONITOR:}";
        width = "100%";
        height = 27;
        radius = 0;
        fixed_center = true;
        background = "#222D31";
        foreground = "#FFFFFF";
        line_size = 3;
        line_color = "#f00";
        border_size = 0;
        padding_left = 0;
        padding_right = 2;
        module_margin_left = 1;
        module_margin_right = 2;

        font-0 = "DejaVu Sans Mono:pixelsize=10;1";
        font-1 = "Font Awesome 7 Free Solid:pixelsize=10;1";
        font-2 = "Font Awesome 7 Brands:pixelsize=10;1";

        modules-left = "i3";
        modules-center = "date";
        modules-right = "pulseaudio memory cpu wlan battery";

        cursor_click = "pointer";
        cursor_scroll = "ns-resize";
      };

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index_sort = true;
        wrapping_scroll = false;
        strip-wsnumbers = true;
        pin-workspaces = true;

        label-focused = "%name%";
        label-focused-background = "#16a085";
        label-focused-underline = "#00FF11";
        label-focused-padding = 2;

        label-unfocused = "%name%";
        label-unfocused-padding = 2;

        label-urgent = "%name%";
        label-urgent-background = "#BA2922";
        label-urgent-padding = 2;

        label-visible = "%name%";
        label-visible-background = "#353836";
        label-visible-padding = 2;
      };

      "module/date" = {
        type = "internal/date";
        interval = 5;
        date = "%Y-%m-%d";
        time = "%H:%M";
        label = "%date% %time%";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume = "<label-volume>";
        label-volume = "VOL %percentage%%";
        label-volume-padding = 1;
        label-muted = "MUTED";
        label-muted-padding = 1;
      };

      "module/battery" = {
        type = "internal/battery";
        full-at = 99;
        battery = "BAT0";
        adapter = "ADP1";
        poll-interval = 5;
        label-charging = "Bat: CHARGING %percentage%%";
        label-discharging = "Bat: %percentage%%";
        label-full = "Bat: FULL";
        label-charging-padding = 1;
        label-discharging-padding = 1;
        label-full-padding = 1;
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        label = "CPU %percentage%%";
        label-padding = 1;
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        label = "RAM %percentage_used%%";
        label-padding = 1;
      };

      "module/wlan" = {
        type = "internal/network";
        interface-type = "wireless";
        interval = 3;
        format-connected = "<label-connected>";
        label-connected = "WIFI %local_ip% (%essid% %signal%%)";
        label-connected-padding = 1;
        label-disconnected = "WIFI DOWN";
        label-disconnected-padding = 1;
      };
    };
  };
}
