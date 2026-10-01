{
  config,
  pkgs,
  lib,
  ...
}:
{
  hardware = {
    intel-gpu-tools.enable = true;
    # facter = {
    #   enable = true;
    #   reportPath = ./facter.json;
    #   # detected.camera.ipu6.enable = true;
    # };
    bluetooth = {
      enable = true;
      # powerOnBoot = true;
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
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
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

  services.udev.extraRules = ''
    SUBSYSTEM=="powercap", ACTION=="add|change", RUN+="${pkgs.coreutils}/bin/chmod -R o+r /sys%p"
  '';

  systemd.services.rapl-limits = {
    description = "Set RAPL power limits via MMIO";
    wantedBy = [ "default.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      echo 100000000 > /sys/class/powercap/intel-rapl-mmio:0/constraint_0_power_limit_uw
      echo 100000000 > /sys/class/powercap/intel-rapl-mmio:0/constraint_1_power_limit_uw
    '';
  };

  security.wrappers = {
    btop = {
      owner = "root";
      group = "root";
      capabilities = "cap_perfmon+ep";
      source = "${pkgs.btop}/bin/btop";
    };
    btop-cuda = {
      owner = "root";
      group = "root";
      capabilities = "cap_perfmon+ep";
      source = "${(pkgs.writeShellScriptBin "btop-cuda" ''
        exec ${pkgs.btop-cuda}/bin/btop --config ~/.config/btop/btop-cuda.conf "$@"
      '')}/bin/btop-cuda";
    };
    mangohud = {
      owner = "root";
      group = "root";
      capabilities = "cap_perfmon+ep";
      source = "${pkgs.mangohud}/bin/mangohud";
    };
  };
}
