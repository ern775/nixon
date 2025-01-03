{
  inputs,
  pkgs,
  ...
}: let
  system = "x86_64-linux";
  pkgsStable = inputs.nixpkgsStable.legacyPackages.${system};
in {
  home.packages = with pkgs; [
    android-tools
<<<<<<< HEAD
    bottles
=======
    pkgsStable.bottles
>>>>>>> bffca04 (Initial Commit)
    brave
    dopamine
    gamescope
    jamesdsp
    jdk17
    kdePackages.kcalc
    librewolf
    mangohud
    media-downloader
    miru
    onlyoffice-desktopeditors
    picard
    prismlauncher
    protonup
    protonvpn-gui
    python312Full
    qbittorrent
    simplex-chat-desktop
    skypeforlinux
    soulseekqt
    steamtinkerlaunch
    # tauon
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
