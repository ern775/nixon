{ config, ... }:
{
  systemd = {
    services = {
      novideo = {
        script = ''
          /run/current-system/sw/bin/nvidia-smi -lgc 0,1680
          /run/current-system/sw/bin/nvidia-settings -c 0 -a 'GPUGraphicsClockOffsetAllPerformanceLevels'=255
        '';
        wantedBy = [ "default.target" ];
        serviceConfig = {
          Type = "oneshot";
        };
      };
    };
  };
}
