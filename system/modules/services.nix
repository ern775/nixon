{ pkgs, ... }:
{
  services = {
    fwupd.enable = true;
    # system76-scheduler.enable = true;
    # printing = {
    #   enable = true;
    #   drivers = with pkgs; [
    #     canon-capt
    #   ];
    # };
    cloudflare-warp = {
      enable = true;
      package = (pkgs.cloudflare-warp.override {headless = true;}); # disable warp-taskbar
    };
    # input-remapper.enable = true;
    gvfs.enable = true;
    logind = {
      settings.Login = {
        HandleLidSwitch = "ignore";
        KillUserProcesses = false;
      };
    };
  };
}
