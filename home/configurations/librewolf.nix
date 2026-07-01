{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  programs.librewolf = {
    package = pkgs.librewolf-bin;
    enable = true;
    nativeMessagingHosts = [
      pkgs.kdePackages.plasma-browser-integration
    ];
    settings = lib.mkForce { };
  };
}
