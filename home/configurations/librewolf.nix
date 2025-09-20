{ pkgs, ... }:
{
  programs.librewolf = {
    package = pkgs.librewolf-wayland;
    enable = true;
    nativeMessagingHosts = [
      pkgs.kdePackages.plasma-browser-integration
    ];
  };
}
