{ pkgs, ... }:
{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "eren" ];
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
  virtualisation.spiceUSBRedirection.enable = true;

  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  # boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };
  # networking.firewall.trustedInterfaces = [ "waydroid0" ];
  # boot.kernel.sysctl = {
  #   "net.ipv4.ip_forward" = 1;
  #   "net.ipv4.conf.all.forwarding" = 1;
  #   "net.ipv6.conf.all.forwarding" = 1;
  # };
}
