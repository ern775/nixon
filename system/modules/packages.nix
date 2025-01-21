{pkgs, ...}: let
  # system = "x86_64-linux";
  # pkgsStable = inputs.nixpkgsStable.legacyPackages.${system};
in {
  environment = {
    systemPackages = with pkgs; [
      alejandra
      exfatprogs
      git
      home-manager
      kate
      lshw
      nixd
      nvtopPackages.full
      pciutils
      (python3.withPackages (p: with p; [pynvml]))
      p7zip
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
