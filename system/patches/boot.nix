{
  config,
  pkgs,
  ...
}: let
  tether-fix = pkgs.callPackage ./tether-fix.nix {
    kernel = config.boot.kernelPackages.kernel;
  };
in {
  boot.extraModulePackages = [
    (tether-fix.overrideAttrs (_: {
      patches = [./rndis-patch];
    }))
  ];
  boot.initrd.prepend = ["./acpi_override"];
}
