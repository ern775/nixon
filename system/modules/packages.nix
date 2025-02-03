{pkgs, ...}: let
  # system = "x86_64-linux";
  # pkgsStable = inputs.nixpkgsStable.legacyPackages.${system};
in {
  environment = {
    systemPackages = with pkgs; [
      alejandra
      exfatprogs
      git
      goverlay
      home-manager
      kate
      kdiskmark
      lshw
      nixd
      nvtopPackages.full
      pciutils
      (python3.withPackages (p: with p; [pynvml]))
      rar
      sysfsutils
      undervolt
      qdirstat
      xsettingsd
      xorg.xrdb
      wget
    ];
    plasma6.excludePackages = with pkgs.kdePackages; [
      khelpcenter
      plasma-browser-integration
      elisa
    ];
  };
}
