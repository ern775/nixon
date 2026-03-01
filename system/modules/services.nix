{ pkgs, ... }:
{
  services = {
    fwupd.enable = true;
    # system76-scheduler.enable = true;
    # printing = {
    #   enable = true;
    #   # drivers = with pkgs; [
    #   #   canon-capt
    #   # ];
    # };
    cloudflare-warp = {
      enable = true;
      package = (pkgs.cloudflare-warp.override { headless = true; }); # disable warp-taskbar
    };
    # input-remapper.enable = true;
    gvfs.enable = true;
    logind = {
      settings.Login = {
        HandleLidSwitch = "ignore";
        KillUserProcesses = false;
      };
    };
    orca.enable = false;
    dbus.implementation = "broker";
    byedpi = {
      enable = true;
      extraArgs = [
        "--disorder=1"
        "--tlsrec=1+s"
      ];
    };
  };

  systemd.services.cloudflare-warp.serviceConfig.LogLevelMax = "notice"; # simply suppress all logs from warp
  systemd.timers.fwupd-refresh.enable = false;
}
