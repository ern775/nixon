{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
let
  system = "x86_64-linux";
  # pkgsStable = inputs.nixpkgsStable.legacyPackages.${system};
  custom-nixpkgs = inputs.custom-nixpkgs.packages.${system};
  # victus-control = pkgs.callPackage ../../pkgs/victus-control/package.nix { };
  homeConfig = inputs.self.homeConfigurations.eren.config;
  # nero = (
  #   pkgs.symlinkJoin {
  #     name = "nero-umu";
  #     buildInputs = [ pkgs.makeWrapper ];
  #     paths = [ pkgs.nero-umu ];
  #   }
  # );
in
{
  environment = {
    systemPackages = with pkgs; [
      alejandra
      android-tools
      # anki-bin
      appimage-run
      # (bottles.override { removeWarningPopup = true; })
      brave
      brightnessctl
      btop
      (writeShellScriptBin "btop-cuda" ''
        exec ${btop-cuda}/bin/btop --config ~/.config/btop/btop-cuda.conf "$@"
      '')
      byedpi
      cachix
      cava
      # cobang
      cpufrequtils
      custom-nixpkgs.dopamine
      custom-nixpkgs.gecit
      custom-nixpkgs.handbrake
      custom-nixpkgs.jdownloader2
      custom-nixpkgs.nero-umu
      custom-nixpkgs.prismlauncher
      # custom-nixpkgs.seanime-denshi
      custom-nixpkgs.seanime.denshi
      custom-nixpkgs.stoat-desktop
      # ddgr
      devenv
      drawy
      element-desktop
      evtest
      evtest-qt
      exfatprogs
      fastfetch
      # faugus-launcher
      ffmpeg-full
      file
      firefox
      fzf
      gale
      gh
      ghostscript
      git
      godot
      gpu-screen-recorder
      gpu-screen-recorder-gtk
      # haruna
      # hayase
      home-manager
      hunspell
      # hunspellDicts.en-gb-ise
      # hunspellDicts.tr_TR
      # iloader
      # input-remapper
      intel-undervolt
      # pkgsStable.jamesdsp
      jdk
      jq
      kdePackages.ark
      kdePackages.kate
      kdePackages.kcalc
      kdePackages.kclock
      kdePackages.kde-gtk-config
      kdePackages.kimageformats
      kdePackages.kolourpaint
      kdePackages.krdc
      kdePackages.ksystemlog
      kdePackages.qtwayland
      kdePackages.sddm-kcm
      kdiskmark
      # kile
      libarchive
      libreoffice-qt6
      # (librewolf.override {nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];})
      (llama-cpp.override { cudaSupport = true; })
      lshw
      # lutris
      magic-wormhole-rs
      man-pages
      mangohud
      media-downloader
      # mindustry-wayland
      moonlight-qt
      mpv
      # my-hp-wmi-control-panel-tui
      # ncdu
      neovim
      # nicotine-plus
      nix-init
      nix-prefetch
      nix-sweep
      nixd
      nixfmt
      nixfmt-tree
      nixpkgs-review
      nvfetcher
      obsidian
      onlyoffice-desktopeditors
      openssh
      opus-tools
      p7zip-rar
      # parabolic
      patchutils
      # pavucontrol
      pciutils
      picard
      proton-vpn-cli
      protontricks
      protonup-qt
      # pkgsStable.protonvpn-gui
      qbittorrent
      qdirstat
      # qemu
      qtscrcpy
      rar
      reco
      ripgrep
      scrcpy
      sgdboop
      signal-desktop
      # steam-run
      # steamtinkerlaunch
      sysfsutils
      tcpdump
      # teams-for-linux
      telegram-desktop
      # testdisk-qt
      # texliveFull
      thunderbird
      tor-browser
      traceroute
      tree-sitter
      umu-launcher
      undervolt
      unzip
      vim
      vlc
      vscode-fhs
      # w3m
      wayland-utils
      waypipe
      wget
      # whatsapp-electron
      xrdb
      xsettingsd
      xsettingsd
      yt-dlp
      zapzap
      # zotero
    ];
    plasma6.excludePackages = with pkgs.kdePackages; [
      khelpcenter
      elisa
      discover
      drkonqi
    ];
    pathsToLink = [
      "/share"
      "/share/zsh"
    ];
    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  # environment.etc."current-system-packages".text =
  #   let
  #     systemPackages = map (p: "${p.name}") config.environment.systemPackages;
  #     homePackages = map (p: "${p.name}") homeConfig.home.packages;
  #     sorted = builtins.sort builtins.lessThan (systemPackages ++ homePackages);
  #     formatted = pkgs.lib.strings.concatLines sorted;
  #   in
  #   formatted;

  nixpkgs.overlays = [
    (final: prev: {
      # nero-umu = prev.nero-umu.overrideAttrs (old: {
      #   src = inputs.nero-umu;
      #   patches = (old.patches or [ ]) ++ [
      #     ../../pkgs/nero-umu/custom-proton.patch
      #     ../../pkgs/nero-umu/main.cpp.patch
      #   ];
      # });
      # handbrake = prev.handbrake.overrideAttrs (previous: {
      #   nativeBuildInputs = (previous.nativeBuildInputs or [ ]) ++ [ pkgs.autoAddDriverRunpath ];
      # });
      espeak = prev.espeak.override {
        mbrolaSupport = false;
        pcaudiolibSupport = false;
        sonicSupport = false;
      };
      freerdp = prev.freerdp.override {
        withWaylandSupport = true;
        openh264 = null;
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
      # waypipe = prev.waypipe.override {
      #   ffmpeg = prev.ffmpeg_8;
      # };
      # moonlight-qt = prev.moonlight-qt.override {
      #   ffmpeg = prev.ffmpeg_8;
      # };
    })
  ];
}
