{ pkgs, ... }: {
  home.pointerCursor = {
    x11.enable = true;
    name = "DMZ-White";
    package = pkgs.vanilla-dmz;
    size = 40;
    gtk.enable = true;
  };
}
