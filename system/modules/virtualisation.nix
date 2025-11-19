{ pkgs, ... }:
{
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [ "eren" ];

  virtualisation.libvirtd.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  virtualisation.spiceUSBRedirection.enable = true;

  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

  # virtualisation.waydroid = {
  #   enable = true;
  #   package = pkgs.waydroid-nftables;
  # };
}
