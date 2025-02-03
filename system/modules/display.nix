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
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
