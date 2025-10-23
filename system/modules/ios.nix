{ pkgs, ... }:
{
  services.usbmuxd.enable = true;
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    libimobiledevice
  ];
}
