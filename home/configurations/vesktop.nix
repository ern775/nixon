{ lib, ... }:
{
  programs.vesktop = {
    enable = true;
    # vencord.useSystem = true;
    vencord.settings = lib.mkForce { };
  };
}
