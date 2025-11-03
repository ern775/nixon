{ pkgs, config, ... }:
let
  victus-control = (pkgs.callPackage ../../pkgs/victus-control/package.nix { });
in
{
  boot = {
    extraModulePackages = [
      (config.boot.kernelPackages.callPackage ../../pkgs/hp-wmi-fan-and-backlight-control/default.nix { })
    ];
    extraModprobeConfig = ''
      options hp-wmi force_fan_control_support=true
    '';
  };
  environment.systemPackages = [ victus-control ];
  systemd = {
    packages = [
      victus-control
    ];
    # https://github.com/NixOS/nixpkgs/issues/81138
    services = {
      victus-backend.wantedBy = [ "multi-user.target" ];
    };
  };
}
