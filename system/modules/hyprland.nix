{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [ inputs.noctalia.nixosModules.default ];
  programs = {
    hyprland = {
      enable = true;
      # set the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    # hyprlock.enable = true;
  };
  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://noctalia.cachix.org"
    ];
    trusted-substituters = [
      "https://hyprland.cachix.org"
      "https://noctalia.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.noctalia-shell = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    target = "hyprland-session.target";
  };
  systemd.user = {
    targets.hyprland-session = {
      description = "hyprland compositor session";
      documentation = [ "man:systemd.special(7)" ];
      bindsTo = [ "graphical-session.target" ];
      wants = [ "graphical-session-pre.target" ];
      after = [ "graphical-session-pre.target" ];
      restartTriggers = [ config.services.noctalia-shell.package ];
    };
  };

  environment.systemPackages = with pkgs; [
    # hyprlock
    # hyprlauncher
    # hyprpolkitagent
    # brightnessctl
    grimblast
    # networkmanagerapplet
    hypridle
    # hyprshutdown
    quickshell
    (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs {
      # patches = [
      #   ../../pkgs/noctalia-shell/brightness.patch
      # ];
    })
    kdePackages.kirigami.unwrapped
  ];
}
