{ config, pkgs, ... }: {
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    # nvidia = {
    #   modesetting.enable = true;
    #   open = false;
    #   nvidiaSettings = true;
    #   package = config.boot.kernelPackages.nvidiaPackages.stable;
    #   prime = {
    #     sync.enable = true;
    #     amdgpuBusId = "PCI:4:0:0";
    #     nvidiaBusId = "PCI:1:0:0";
    #   };
    # };
  };

  services = {
    xserver = {
      enable = true;

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
          i3blocks
          rofi # original: dmenu
        ];
      };

      displayManager = {
          startx.enable = true;
          lightdm.enable = true;
      };

      desktopManager = {
        xterm.enable = false;
      };

    };

    autorandr.enable = true;

    picom = {
      enable = true;
      backend = "xrender";
      fade = true;
      shadow = true;
      vSync = true;
      settings = {
        shadow-radius = 12;
        shadow-offset-x = -12;
        shadow-offset-y = -12;
        shadow-opacity = 0.7;
        corner-radius = 10;
        shadow-exclude = [
          "name = 'Notification'"
          "class_g = 'Conky'"
          "class_g ?= 'Notify-osd'"
          "class_g = 'Cairo-clock'"
          "_GTK_FRAME_EXTENTS@:c"
        ];
      };
    };

    desktopManager = {
      gnome.enable = true;
    };
  };
}
