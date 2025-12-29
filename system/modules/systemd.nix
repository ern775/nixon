{
  pkgs,
  config,
  ...
}:
{
  systemd = {
    services = {
      novideo = {
        script = ''
          ${config.hardware.nvidia.package.bin}/bin/nvidia-smi -lgc 0,1680
          ${config.hardware.nvidia.package.settings}/bin/nvidia-settings -c 0 -a 'GPUGraphicsClockOffsetAllPerformanceLevels'=255
        '';
        wantedBy = [ "default.target" ];
        serviceConfig = {
          Type = "oneshot";
        };
      };
      byedpi = {
        script = ''
          ${pkgs.byedpi}/bin/ciadpi -r 1+s
        '';
        wantedBy = [ "default.target" ];
      };
    };
  };
}
