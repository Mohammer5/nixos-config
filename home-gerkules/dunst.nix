{ pkgs, ... }: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        frame_color = "#00FF11";
        font = "DejaVu Sans Mono 10";
      };

      urgency_normal = {
        background = "#222D31";
        foreground = "#FFFFFF";
        timeout = 10;
      };

      urgency_critical = {
        background = "#900000";
        foreground = "#FFFFFF";
        frame_color = "#FF0000";
        timeout = 0;
      };
    };
  };
}
