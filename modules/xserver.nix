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

          # ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1-1 --mode 1440x900 --primary
          sessionCommands = ''
            ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-2 --primary
          '';
      };

      desktopManager = {
        xterm.enable = false;
      };

    };

    desktopManager = {
      gnome.enable = true;
    };
  };
}
