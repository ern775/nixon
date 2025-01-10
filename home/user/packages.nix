{pkgs, ...}: let
  # system = "x86_64-linux";
  # pkgsStable = inputs.nixpkgsStable.legacyPackages.${system};
in {
  home.packages = with pkgs; [
    android-tools
    bottles
    dopamine
    jamesdsp
    jdk17
    kdePackages.kcalc
    librewolf
    mangohud
    media-downloader
    miru
    mpv
    onlyoffice-desktopeditors
    picard
    protonup
    protonvpn-gui
    python312Full
    qbittorrent
    signal-desktop
    steamtinkerlaunch
    teams-for-linux
    thunderbird
    vesktop
    vlc
    vscodium-fhs
    yt-dlp
    zapzap
  ];
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
  };
}
