{ pkgs, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    settings = {
      source = "~/.config/hypr/hypr.conf";
    };
  };
  home.packages = with pkgs; [
    waybar
    hyprlock
    wlogout
    hyprlauncher
    brightnessctl
    hyprshot
    networkmanagerapplet
    hyprpaper
    swayidle
    hyprshutdown
    hyprlock
  ];
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-hyprland
  #     kdePackages.xdg-desktop-portal-kde
  #   ];
  # };

  # services.hyprpaper = {
  #   enable = true;
  #   settings = {
  #     ipc = "on";
  #     splash = false;
  #     splash_offset = 2.0;

  #     preload = ["~/system/home/images/gruvbox-dark-blue.png"];

  #     wallpaper = [
  #       ", ~/system/home/images/gruvbox-dark-blue.png"
  #     ];
  #   };
  # };
}
