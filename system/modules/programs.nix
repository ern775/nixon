{ pkgs, inputs, ... }:
let
  system = "x86_64-linux";
  custom-nixpkgs = inputs.custom-nixpkgs.packages.${system};
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
        custom-nixpkgs.dw-proton
        custom-nixpkgs.proton-cachyos
      ];
    };
    gamemode.enable = true;
    gamescope.enable = true;
    # thunar.enable = true;
    zsh.enable = true;
    gpu-screen-recorder.enable = true;
    virt-manager.enable = true;
    localsend.enable = true;
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };
  users.users.eren.extraGroups = [ "wireshark" ];
}
