{
  pkgs,
  inputs,
  ...
}:
let
  system = "x86_64-linux";
  pkgsStable = inputs.nixpkgsStable.legacyPackages.${system};
  # nero = pkgs.callPackage ../../pkgs/nero-umu/package.nix { inherit inputs; };
  # nero = (
  #   pkgs.symlinkJoin {
  #     name = "nero-umu";
  #     buildInputs = [ pkgs.makeWrapper ];
  #     paths = [ pkgs.nero-umu ];
  #   }
  # );
  dopamine = pkgs.callPackage ../../pkgs/dopamine/package.nix { };
  # faugus-launcher = pkgs.callPackage ../../pkgs/faugus-launcher/package.nix {};
  hayase = pkgs.callPackage ../../pkgs/hayase/package.nix { };
  # mindustry-beta = pkgs.callPackage ../../pkgs/mindustry/package.nix { };
  jdownloader2 = pkgs.callPackage ../../pkgs/jdownloader2/package.nix { inherit inputs; };
in
{
  home.packages = with pkgs; [
    android-tools
    # anki-bin
    # (bottles.override { removeWarningPopup = true; })
    byedpi
    cava
    cobang
    dopamine
    pkgsStable.jamesdsp
    jdk
    fastfetch
    ffmpeg-full
    # handbrake
    # haruna
    hunspell
    hunspellDicts.en-gb-ise
    hunspellDicts.tr_TR
    intel-gpu-tools
    intel-undervolt
    godot
    # input-remapper
    kdePackages.kcalc
    kdePackages.kclock
    kdePackages.krdc
    # kile
    # (librewolf.override {nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];})
    # lutris
    mangohud
    media-downloader
    # mindustry-wayland
    mpv
    # nicotine-plus
    nix-init
    nixpkgs-review
    onlyoffice-desktopeditors
    opusTools
    patchutils
    # parabolic
    # pavucontrol
    picard
    # prismlauncher
    protontricks
    protonup-qt
    # pkgsStable.protonvpn-gui
    qbittorrent
    # qemu
    # qtscrcpy
    sgdboop
    # signal-desktop
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
    jdownloader2
  ];

  nixpkgs.overlays = [
    (final: prev: {
      nero-umu = prev.nero-umu.overrideAttrs (old: {
        src = inputs.nero-umu;
        patches = (old.patches or [ ]) ++ [
          ../../pkgs/nero-umu/neroprefixsettings.cpp.patch
          ../../pkgs/nero-umu/nerorunner.cpp.patch
        ];
      });
    })
  ];
}
