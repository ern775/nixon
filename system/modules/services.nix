{lib, ...}: {
  services = {
    fwupd.enable = true;
    system76-scheduler.enable = true;
    printing.enable = true;
    cloudflare-warp.enable = true;
    input-remapper.enable = true;
    gvfs.enable = true;
  };

  systemd.user.services.warp-taskbar.enable = lib.mkForce false;
}
