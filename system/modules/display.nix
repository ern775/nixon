{...}: {
  services = {
    desktopManager = {
      plasma6.enable = true;
    };
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        autoNumlock = true;
      };
    };
  };
  # programs.dconf.enable = true;
}
