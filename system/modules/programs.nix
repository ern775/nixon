{ pkgs, inputs, ... }:
let
  system = "x86_64-linux";
  dw-proton = inputs.dw-proton.packages.${system}.dw-proton;
  proton-cachyos = inputs.custom-nixpkgs.packages.${system}.proton-cachyos;
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
        dw-proton
        proton-cachyos
      ];
    };
    gamemode.enable = true;
    gamescope.enable = true;
    # thunar.enable = true;
    zsh.enable = true;
    gpu-screen-recorder.enable = true;
    virt-manager.enable = true;
    localsend.enable = true;
  };
  users.groups.libvirtd.members = [ "eren" ];
  virtualisation.libvirtd.enable = true;
}
