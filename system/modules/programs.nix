{ pkgs, inputs, ... }:
let
  proton-spritz-bin = pkgs.callPackage ../../pkgs/proton-spritz-bin/package.nix { inherit inputs; };
in
{
  programs = {
    partition-manager.enable = true;
    kdeconnect.enable = true;
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraEnv = {
          MANGOHUD = true;
        };
      };
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        proton-spritz-bin
      ];
    };
    gamemode.enable = true;
    gamescope.enable = true;
    # thunar.enable = true;
    zsh.enable = true;
  };
}
