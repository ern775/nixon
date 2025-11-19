{ pkgs, lib, ... }:
{
  programs.librewolf = {
    package = pkgs.librewolf;
    enable = true;
    nativeMessagingHosts = [
      pkgs.kdePackages.plasma-browser-integration
    ];
    settings = lib.mkForce { };
  };
}
