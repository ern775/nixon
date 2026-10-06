{ pkgs, inputs, ... }:
let
  custom-nixpkgs = inputs.custom-nixpkgs.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  environment.systemPackages = with pkgs; [
    playerctl
    udiskie
    noctalia
    xwayland-satellite
  ];
  programs.niri = {
    enable = true;
    package = custom-nixpkgs.niri-icc;
  };
}
