{
  pkgs,
  inputs,
  ...
}: let
  system = "x86_64-linux";
  pkgsStable = inputs.nixpkgsStable.legacyPackages.${system};
in {
  home.packages = with pkgs; [
    android-tools
    bottles
    cava
    cloudflare-warp
    dopamine
    jamesdsp
    jdk17
    fastfetch
    ffmpeg-full
    haruna
    godot_4
    # input-remapper
    kdePackages.kcalc
    kdePackages.kclock
    (librewolf.override {nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];})
    # lutris
    mangohud
    media-downloader
    mpv
    onlyoffice-desktopeditors
    parabolic
    pavucontrol
    picard
    # prismlauncher
    protonup
    protonup-qt
    protonvpn-gui
    qbittorrent
    qtscrcpy
    steamtinkerlaunch
    steam-run
    # teams-for-linux
    thunderbird
    pkgsStable.vesktop
    vlc
    yt-dlp
    xsettingsd
    zapzap
    # inputs.zen-browser.packages."${system}".default
  ];
}
