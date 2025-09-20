{ lib, pkgs, ... }:
{
  services = {
    fwupd.enable = true;
    system76-scheduler.enable = true;
    # printing = {
    #   enable = true;
    #   drivers = with pkgs; [
    #     canon-capt
    #   ];
    # };
    cloudflare-warp.enable = true;
    # input-remapper.enable = true;
    gvfs.enable = true;
  };

  systemd.user.services.warp-taskbar.enable = lib.mkForce false;
}
