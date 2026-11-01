{ lib, ... }:
{
  specialisation.nvk.configuration = {
    system.nixos.tags = [ "nvk" ];

    # Drop the proprietary driver in this entry
    services.xserver.videoDrivers = lib.mkForce [ "modesetting" ];
    services.xserver.deviceSection = lib.mkForce "";   # Coolbits is nvidia-only

    # These depend on each other, so all must be off
    hardware.nvidia.powerManagement.finegrained = lib.mkForce false;
    hardware.nvidia.prime.offload.enable = lib.mkForce false;
    hardware.nvidia.prime.offload.enableOffloadCmd = lib.mkForce false;

    # Keep nvidia from grabbing the GPU so nouveau can bind
    boot.blacklistedKernelModules = [ "nvidia" "nvidia_drm" "nvidia_modeset" "nvidia_uvm" ];

    # nouveau needs GSP firmware (loaded after boot, not part of the initrd)
    # hardware.enableRedistributableFirmware = true;
  };
}
