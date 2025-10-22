{ config, pkgs, ... }: {  
  #   layout = "us";
  #   xkbVariant = "";
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        sync.enable = true;
        amdgpuBusId = "PCI:4:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  services = {
    # displayManager.defaultSession = "none+i3";
    xserver = {
      enable = true;
      # videoDrivers = [ "nvidia" ];

      # Enable the GNOME Desktop Environment.
      # displayManager.gdm.enable = true;
      # desktopManager.gnome.enable = true;

      # Configure keymap in X11
      # xkb = {
      #   layout = "us";
      #   variant = "";
      # };

      displayManager = {
          startx.enable = true;
          lightdm.enable = true;
      
        # defaultSession = "none+i3";
        # sessionCommands = ''
        #   ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1-1 --mode 1680x1050 --primary
        # '';

          sessionCommands = ''
            ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1-1 --mode 1440x900 --primary
          '';
      };

      desktopManager = {
        xterm.enable = false;
        gnome.enable = true;
        # xfce = {
        #  enable = true;
        #  noDesktop = true;
        #  enableXfwm = false;
        # };
      };

      windowManager.i3 = {
        enable = true;
        # package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
          # dmenu
          # i3bar
          i3status
	    #    i3lock
          i3blocks
          rofi
        ];
      };
    };
  };
}
