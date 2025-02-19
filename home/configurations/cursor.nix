{pkgs, ...}: {
  gtk = {
    enable = true;
    cursorTheme = {
      name = "DMZ-Black";
      package = pkgs.vanilla-dmz;
      size = 24;
    };
  };

  home.pointerCursor = {
    name = "DMZ-Black";
    package = pkgs.vanilla-dmz;
    size = 24;
    # gtk.enable = true;
    # x11 = {
    #   enable = true;
    #   defaultCursor = "DMZ-Black";
    # };
  };
}
