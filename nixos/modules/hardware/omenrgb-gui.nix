{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.hardware.omenrgb;
in
{
  options.hardware.omenrgb = {
    enable = lib.mkEnableOption "Keyboard backlight rgb controller for HP Omen Laptops";
    package = lib.mkPackageOption pkgs "omenrgb" { };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      extraModulePackages = with config.boot.kernelPackages; [ hp-omen-wmi ];
      kernelModules = [ "hp-wmi" ];
    };

    services.udev.packages = [ cfg.package ];

    environment = {
      systemPackages = [
        cfg.package
        pkgs.gtk3
      ];

      variables = {
        GSETTINGS_SCHEMA_DIR = "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
      };

    };
  };

  meta.maintainers = pkgs.omenrgb.meta.maintainers;
}
