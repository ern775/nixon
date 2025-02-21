{...}: {
  services = {
    fwupd.enable = true;
    system76-scheduler.enable = true;
    tailscale.enable = true;
    printing.enable = true;
    cloudflare-warp.enable = true;
    input-remapper.enable = true;
    gvfs.enable = true;
  };
}
