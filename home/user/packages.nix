{
  pkgs,
  inputs,
  ...
}:
let
  system = "x86_64-linux";
  # pkgsStable = inputs.nixpkgsStable.legacyPackages.${system};
  nix-sweep = inputs.nix-sweep.packages.${system}.default;
  # nero = pkgs.callPackage ../../pkgs/nero-umu/package.nix { };
  # nero = (
  #   pkgs.symlinkJoin {
  #     name = "nero-umu";
  #     buildInputs = [ pkgs.makeWrapper ];
  #     paths = [ pkgs.nero-umu ];
  #   }
  # );
  dopamine = pkgs.callPackage ../../pkgs/dopamine/package.nix { inherit inputs; };
  # faugus-launcher = pkgs.callPackage ../../pkgs/faugus-launcher/package.nix {};
  # hayase = pkgs.callPackage ../../pkgs/hayase/package.nix { };
  # mindustry-beta = pkgs.callPackage ../../pkgs/mindustry/package.nix { };
  jdownloader2 = pkgs.callPackage ../../pkgs/jdownloader2/package.nix { inherit inputs; };
  # vlc-3-0-20 = pkgs.callPackage ../../pkgs/vlc/package.nix { };
  # iloader = pkgs.callPackage ../../pkgs/iloader/package.nix { };
  # whatsapp-electron = pkgs.callPackage ../../pkgs/whatsapp-electron/package.nix { };
in
{
  home.packages = with pkgs; [
    altus
    android-tools
    # anki-bin
    # (bottles.override { removeWarningPopup = true; })
    byedpi
    cava
    cobang
    dopamine
    # pkgsStable.jamesdsp
    jdk
    fastfetch
    ffmpeg-full
    fzf
    handbrake
    # haruna
    hunspell
    # hunspellDicts.en-gb-ise
    # hunspellDicts.tr_TR
    intel-gpu-tools
    intel-undervolt
    gh
    godot
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    # input-remapper
    kdePackages.kcalc
    kdePackages.kclock
    kdePackages.krdc
    kdePackages.kde-gtk-config
    kdePackages.kimageformats
    # kile
    # (librewolf.override {nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];})
    # libreoffice-qt6
    # lutris
    mangohud
    media-downloader
    # mindustry-wayland
    mpv
    # ncdu
    # nicotine-plus
    nix-init
    nix-sweep
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
    signal-desktop
    # steamtinkerlaunch
    # steam-run
    # teams-for-linux
    telegram-desktop
    # testdisk-qt
    # texliveFull
    thunderbird
    tor-browser
    umu-launcher
    # whatsapp-electron
    vlc
    yt-dlp
    xsettingsd
    # zapzap
    nero-umu
    # faugus-launcher
    # hayase
    jdownloader2
    # iloader
    # vscode-fhs
  ];

  nixpkgs.overlays = [
    (final: prev: {
      nero-umu = prev.nero-umu.overrideAttrs (old: {
        src = inputs.nero-umu;
        patches = (old.patches or [ ]) ++ [
          ../../pkgs/nero-umu/custom-proton.patch
        ];
      });
      handbrake = prev.handbrake.overrideAttrs (previous: {
        nativeBuildInputs = (previous.nativeBuildInputs or [ ]) ++ [ pkgs.autoAddDriverRunpath ];
      });
      espeak = prev.espeak.override {
        mbrolaSupport = false;
        pcaudiolibSupport = false;
        sonicSupport = false;
      };
      # zapzap = prev.zapzap.overrideAttrs (old: {
      #   buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.qt6.qtbase ];
      # });
      # whatsapp-electron = prev.whatsapp-electron.overrideAttrs (old: {
      #   patches = (old.patches or [ ]) ++ [
      #     ../../pkgs/whatsapp-electron/wayland-icon.patch
      #   ];
      # });
      # sgdboop = prev.sgdboop.overrideAttrs (old: {
      #   patches = (old.patches or [ ]) ++ [
      #     ../../pkgs/sgdboop/remove-unused-arg.patch
      #   ];
      # });
    })
  ];
}
