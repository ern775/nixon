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
    anki-bin
    bottles
    cava
    cloudflare-warp
    dopamine
    pkgsStable.jamesdsp
    jdk17
    fastfetch
    ffmpeg-full
    handbrake
    # haruna
    intel-gpu-tools
    # godot
    # input-remapper
    kdePackages.kcalc
    kdePackages.kclock
    # kile
    # (librewolf.override {nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];})
    # lutris
    mangohud
    media-downloader
    mpv
    nicotine-plus
    onlyoffice-desktopeditors
    opusTools
    peazip
    # parabolic
    # pavucontrol
    picard
    # prismlauncher
    kdePackages.plasma-browser-integration
    protonup
    protonup-qt
    pkgsStable.protonvpn-gui
    qbittorrent
    qtscrcpy
    steamtinkerlaunch
    steam-run
    # teams-for-linux
    testdisk-qt
    # texliveFull
    thunderbird
    umu-launcher
    pkgsStable.vesktop
    vlc
    yt-dlp
    xsettingsd
    zapzap
    # inputs.zen-browser.packages."${system}".default
  ];
}
