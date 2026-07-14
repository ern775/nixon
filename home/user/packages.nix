{
  pkgs,
  inputs,
  ...
}:
let
  system = "x86_64-linux";
  pkgsStable = inputs.nixpkgsStable.legacyPackages.${system};
  custom-nixpkgs = inputs.custom-nixpkgs.packages.${system};
  nix-sweep = inputs.nix-sweep.packages.${system}.default;
  # nero = pkgs.callPackage ../../pkgs/nero-umu/package.nix { };
  # nero = (
  #   pkgs.symlinkJoin {
  #     name = "nero-umu";
  #     buildInputs = [ pkgs.makeWrapper ];
  #     paths = [ pkgs.nero-umu ];
  #   }
  # );
  # dopamine = pkgs.callPackage ../../pkgs/dopamine/package.nix { };
  # faugus-launcher = pkgs.callPackage ../../pkgs/faugus-launcher/package.nix {};
  # hayase = pkgs.callPackage ../../pkgs/hayase/package.nix { };
  # mindustry-beta = pkgs.callPackage ../../pkgs/mindustry/package.nix { };
  # jdownloader2 = pkgs.callPackage ../../pkgs/jdownloader2/package.nix { inherit inputs; };
  # vlc-3-0-20 = pkgs.callPackage ../../pkgs/vlc/package.nix { };
  # iloader = pkgs.callPackage ../../pkgs/iloader/package.nix { };
  # whatsapp-electron = pkgs.callPackage ../../pkgs/whatsapp-electron/package.nix { };
  # seanime = pkgs.callPackage ../../pkgs/seanime/package.nix { };
  my-hp-wmi-control-panel-tui = pkgs.callPackage ../../pkgs/my-hp-wmi-control-panel-tui/package.nix {
    inherit inputs;
  };
in
{
  home.packages = with pkgs; [
    # altus
    android-tools
    # anki-bin
    # (bottles.override { removeWarningPopup = true; })
    brave
    byedpi
    cava
    # cobang
    custom-nixpkgs.dopamine
    ddgr
    drawy
    # pkgsStable.jamesdsp
    jdk
    fastfetch
    ffmpeg-full
    firefox
    fzf
    handbrake
    # haruna
    hunspell
    # hunspellDicts.en-gb-ise
    # hunspellDicts.tr_TR
    intel-gpu-tools
    intel-undervolt
    gale
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
    kdePackages.kolourpaint
    kdePackages.ksystemlog
    kdePackages.sddm-kcm
    wayland-utils
    # kile
    # (librewolf.override {nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];})
    libreoffice-qt6-fresh
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
    nvfetcher
    obsidian
    onlyoffice-desktopeditors
    opus-tools
    patchutils
    # parabolic
    # pavucontrol
    picard
    # prismlauncher
    protontricks
    protonup-qt
    proton-vpn-cli
    # pkgsStable.protonvpn-gui
    reco
    qbittorrent
    # qemu
    qtscrcpy
    scrcpy
    sgdboop
    signal-desktop
    # steamtinkerlaunch
    # steam-run
    tcpdump
    # teams-for-linux
    telegram-desktop
    # testdisk-qt
    # texliveFull
    thunderbird
    tor-browser
    umu-launcher
    # whatsapp-electron
    w3m
    magic-wormhole-rs
    vlc
    yt-dlp
    xsettingsd
    zapzap
    # faugus-launcher
    # hayase
    custom-nixpkgs.jdownloader2
    # custom-nixpkgs.seanime-denshi
    # iloader
    vscode-fhs
    # zotero
    custom-nixpkgs.seanime.denshi
    custom-nixpkgs.gecit
    # my-hp-wmi-control-panel-tui
    (llama-cpp.override { cudaSupport = true; })
  ];

  nixpkgs.overlays = [
    (final: prev: {
      # nero-umu = prev.nero-umu.overrideAttrs (old: {
      #   src = inputs.nero-umu;
      #   patches = (old.patches or [ ]) ++ [
      #     ../../pkgs/nero-umu/custom-proton.patch
      #     ../../pkgs/nero-umu/main.cpp.patch
      #   ];
      # });
      handbrake = prev.handbrake.overrideAttrs (previous: {
        nativeBuildInputs = (previous.nativeBuildInputs or [ ]) ++ [ pkgs.autoAddDriverRunpath ];
      });
      espeak = prev.espeak.override {
        mbrolaSupport = false;
        pcaudiolibSupport = false;
        sonicSupport = false;
      };
      # vesktop = prev.vesktop.override {
      #   pnpm_10_29_2 = final.pnpm_10;
      # };
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
      #   vscode = prev.vscode.overrideAttrs (previous: {
      #     src = prev.fetchurl {
      #       name = "VSCode_1.108.2_linux-x64.tar.gz";
      #       url = "https://update.code.visualstudio.com/1.108.2/linux-x64/stable";
      #       hash = "sha256-RqBae6s6y2XnXqtKbrKkMRwALKLfNE7mBFwOwwomG10=";
      #     };
      #     vscodeServer = prev.srcOnly {
      #       name = "vscode-server-c9d77990917f3102ada88be140d28b038d1dd7c7.tar.gz";
      #       src = prev.fetchurl {
      #         name = "vscode-server-c9d77990917f3102ada88be140d28b038d1dd7c7.tar.gz";
      #         url = "https://update.code.visualstudio.com/commit:c9d77990917f3102ada88be140d28b038d1dd7c7/server-linux-x64/stable";
      #         hash = "sha256-bUnM+editWCYiiqR3mlIw4BRrM5gHd6T2GO65VKTDSE=";
      #       };
      #       stdenv = prev.stdenvNoCC;
      #     };
      #   });
      vlc-nightly =
        let
          revision = "734cb67180e5fe97fabff8c99e3f10831e73c016";
          vlc-without-qt5 = prev.vlc.override { withQt5 = false; };
        in
        vlc-without-qt5.overrideAttrs (old: {
          version = "nightly";
          src = final.fetchFromGitLab {
            domain = "code.videolan.org";
            owner = "videolan";
            repo = "vlc";
            rev = revision;
            hash = "sha256-HGdzgqFdGCzVs+4CZU7HqPcgiDm0kImqC1axxwDZOm0=";
          };

          nativeBuildInputs = old.nativeBuildInputs ++ [
            prev.qt6.wrapQtAppsHook
            prev.bison
          ];

          buildInputs =
            old.buildInputs
            ++ (with prev.qt6; [
              qtwayland
              qtbase
              qtsvg
            ]);

          postFixup = old.postFixup + ''
            remove-references-to -t "${prev.qt6.qtbase.dev}" $out/lib/vlc/plugins/gui/libqt_plugin.so
          '';

          preConfigure = ''
            echo ${revision} > src/revision.txt
          '';
          configureFlags = old.configureFlags ++ [
            "--disable-skins2"
          ];
        });
    })
  ];
}
