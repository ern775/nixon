{ pkgs, ... }:
{
  users.users.eren = {
    isNormalUser = true;
    description = "Eren";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
      "kvm"
      "dialout"
    ];
    shell = pkgs.zsh;
  };
}
