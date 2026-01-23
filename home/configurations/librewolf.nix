{ pkgs, lib, inputs, ... }:
{
  programs.librewolf = {
    package = inputs.nixpkgsStable.legacyPackages.x86_64-linux.librewolf;
    enable = true;
    nativeMessagingHosts = [
      pkgs.kdePackages.plasma-browser-integration
    ];
    settings = lib.mkForce { };
  };
}
