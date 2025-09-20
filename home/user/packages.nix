{
  pkgs,
  inputs,
  ...
}:
let
  system = "x86_64-linux";
  pkgsStable = inputs.nixpkgsStable.legacyPackages.${system};
  # nero-umu = pkgs.callPackage ../../pkgs/nero-umu/package.nix { };
  # dopamine = pkgs.callPackage ../../pkgs/dopamine/package.nix { };
  # faugus-launcher = pkgs.callPackage ../../pkgs/faugus-launcher/package.nix {};
  hayase = pkgs.callPackage ../../pkgs/hayase/package.nix { };
  # mindustry-beta = pkgs.callPackage ../../pkgs/mindustry/package.nix { };
in
{
  home.packages = with pkgs; [
    android-tools
    anki-bin
    # (bottles.override { removeWarningPopup = true; })
    byedpi
    cava
    cloudflare-warp
    cobang
    dopamine
    pkgsStable.jamesdsp
    jdk
    fastfetch
    ffmpeg-full
    # handbrake
    # haruna
    intel-gpu-tools
    intel-undervolt
    godot
    # input-remapper
    kdePackages.kcalc
    kdePackages.kclock
    # kile
    # (librewolf.override {nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];})
    # lutris
    mangohud
    media-downloader
    mindustry-wayland
    mpv
    # nicotine-plus
    nix-init
    onlyoffice-desktopeditors
    opusTools
    # parabolic
    # pavucontrol
    picard
    # prismlauncher
    protonup
    protonup-qt
    pkgsStable.protonvpn-gui
    qbittorrent
    # qemu
    qtscrcpy
    sgdboop
    signal-desktop
    steamtinkerlaunch
    # steam-run
    teams-for-linux
    telegram-desktop
    # testdisk-qt
    # texliveFull
    thunderbird
    tor-browser
    umu-launcher
    vlc
    yt-dlp
    xsettingsd
    zapzap
    nero-umu
    # faugus-launcher
    hayase
  ];

  nixpkgs.overlays = [
    (final: prev: {
      nero-umu = prev.nero-umu.overrideAttrs (old: {
        patches = (old.patches or []) ++ [ ../../pkgs/nero-umu/neroprefix.patch ];
        preFixup = (old.preFixup or "") + ''
          qtWrapperArgs+=(
            "--set" "PROTON_USE_NTSYNC" "1" \
            "--set" "WINE_USE_TAKE_FOCUS" "1"
          )
        '';
      });
    })
  ];
}
