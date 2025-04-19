{ config, pkgs, ... }:

let
  tether-fix = pkgs.callPackage ../patches/tether-fix.nix {
    kernel = config.boot.kernelPackages.kernel;
  };
in {
  boot.extraModulePackages = [
      (tether-fix.overrideAttrs (_: {
        patches = [ ../patches/rndis-patch ];
      }))
    ];
}
