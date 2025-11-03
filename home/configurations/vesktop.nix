{ lib, ... }:
{
  programs.vesktop = {
    enable = true;
    # package = inputs.nixpkgsStable.legacyPackages.x86_64-linux.vesktop;
    # vencord.useSystem = true;
    vencord.settings = lib.mkForce { };
  };
}
