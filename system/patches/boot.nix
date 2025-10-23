{
  config,
  pkgs,
  ...
}:
let
  tether-fix = pkgs.callPackage ./mute-led.nix {
    kernel = config.boot.kernelPackages.kernel;
  };
in
{
  boot.extraModulePackages = [
    (tether-fix.overrideAttrs (_: {
      patches = [ ./alc269_patch ];
    }))
  ];
}
