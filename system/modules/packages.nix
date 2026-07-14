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
in
{
  environment = {
    systemPackages = with pkgs; [
      alejandra
      appimage-run
      brightnessctl
      cpufrequtils
      devenv
      exfatprogs
      file
      jq
      git
      ghostscript
      home-manager
      kdePackages.kate
      kdePackages.ark
      kdePackages.qtwayland
      kdiskmark
      libarchive
      lshw
      man-pages
      neovim
      nixd
      nixfmt
      nixfmt-tree
      nix-prefetch
      openssh
      p7zip-rar
      pciutils
      rar
      sysfsutils
      traceroute
      undervolt
      unzip
      qdirstat
      vim
      xsettingsd
      xrdb
      wget
      waypipe
      custom-nixpkgs.nero-umu
      (kodi.withPackages (
        kodiPkgs: with kodiPkgs; [
          pvr-iptvsimple
        ]
      ))
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

  environment.etc."current-system-packages".text =
    let
      systemPackages = map (p: "${p.name}") config.environment.systemPackages;
      homePackages = map (p: "${p.name}") homeConfig.home.packages;
      sorted = builtins.sort builtins.lessThan (systemPackages ++ homePackages);
      formatted = pkgs.lib.strings.concatLines sorted;
    in
    formatted;

  nixpkgs.overlays = [
    (final: prev: {
      espeak = prev.espeak.override {
        mbrolaSupport = false;
        pcaudiolibSupport = false;
        sonicSupport = false;
      };
    })
  ];
}
