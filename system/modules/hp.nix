{
  lib,
  pkgs,
  ...
}: {
  boot = lib.mkIf (lib.versionAtLeast pkgs.linux.version "6.1") {
    kernelModules = ["hp-wmi"];
  };
}
