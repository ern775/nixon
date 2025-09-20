{ pkgs, ... }:
let
  # system = "x86_64-linux";
  # pkgsStable = inputs.nixpkgsStable.legacyPackages.${system};
  # omenrgb = pkgs.callPackage ../../pkgs/omenrgb/package.nix { };
in
{
  environment = {
    systemPackages = with pkgs; [
      alejandra
      exfatprogs
      git
      ghostscript
      home-manager
      kdePackages.kate
      kdePackages.ark
      kdePackages.qtwayland
      kdiskmark
      lshw
      man-pages
      nixd
      nixfmt-rfc-style
      nixfmt-tree
      nvtopPackages.full
      p7zip-rar
      pciutils
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
    pathsToLink = [ "/share" ];
    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
