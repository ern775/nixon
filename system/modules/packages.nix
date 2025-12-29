{
  pkgs,
  config,
  inputs,
  ...
}:
let
  # system = "x86_64-linux";
  # pkgsStable = inputs.nixpkgsStable.legacyPackages.${system};
  # victus-control = pkgs.callPackage ../../pkgs/victus-control/package.nix { };
  homeConfig = inputs.self.homeConfigurations.eren.config;
in
{
  environment = {
    systemPackages = with pkgs; [
      alejandra
      appimage-run
      cpufrequtils
      exfatprogs
      file
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
      openssh
      p7zip-rar
      pciutils
      rar
      sysfsutils
      undervolt
      unzip
      qdirstat
      vim
      xsettingsd
      xorg.xrdb
      wget
    ];
    plasma6.excludePackages = with pkgs.kdePackages; [
      khelpcenter
      elisa
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
