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
    cloudflare-warp
    dopamine
    jamesdsp
    jdk17
    ffmpeg-full
    godot_4
    input-remapper
    kdePackages.kcalc
    kdePackages.kclock
    (librewolf.override {nativeMessagingHosts = [pkgs.plasma-browser-integration];})
    mangohud
    media-downloader
    miru
    mpv
    onlyoffice-desktopeditors
    parabolic
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
  ];
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
  };
}
