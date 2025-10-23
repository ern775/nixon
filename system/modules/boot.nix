{ pkgs, config, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "intel_idle.max_cstate=4"
      # "intel_pstate=disable"
      "split_lock_detect=off"
    ];
    kernel.sysctl = {
      "kernel.split_lock_mitigate" = 0;
    };
    kernelModules = [ "ntsync" ];
    extraModulePackages = [
      (config.boot.kernelPackages.callPackage ../../pkgs/hp-wmi-fan-and-backlight-control/default.nix { })
      # (config.boot.kernelPackages.callPackage ../../pkgs/hp-omen-wmi/package.nix { })
    ];
    extraModprobeConfig = ''
      options hp-wmi force_fan_control_support=true
    '';
  };
}
