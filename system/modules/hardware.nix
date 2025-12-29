{
  config,
  pkgs,
  lib,
  ...
}:
{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      dynamicBoost.enable = false;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
  services = {
    fstrim.enable = true;
    undervolt = {
      enable = true;
      turbo = 1;
      p1.limit = 35;
      p1.window = 5;
      p2.limit = 45;
      p2.window = 1;
    };
    xserver = {
      enable = true;
      exportConfiguration = true;
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "tr";
        variant = "";
      };
      deviceSection = ''
        Option "Coolbits" "28"
      '';
    };
    hardware.bolt.enable = true;
  };
  powerManagement = { 
    enable = true;
    cpufreq.min = 400000;
  };
}
