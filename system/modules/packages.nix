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
      kdePackages.kate
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
      elisa
      drkonqi
    ];
    pathsToLink = ["/share/zsh"];
    sessionVariables.NIXOS_OZONE_WL = "1";
    };
}
