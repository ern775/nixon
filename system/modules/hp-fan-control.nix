{ pkgs, inputs, ... }:
let
  system = "x86_64-linux";
  victus-control = inputs.custom-nixpkgs.packages.${system}.victus-control;
in
{
  imports = [ inputs.tuxov.nixosModules.default ];
  hardware.hp-wmi-control = {
    enable = true;
    victus-15-support.enable = true;
  };
  # boot = {
  #   # extraModulePackages = [
  #   #   (config.boot.kernelPackages.callPackage ../../pkgs/hp-wmi-fan-and-backlight-control/default.nix { })
  #   # ];
  #   extraModprobeConfig = ''
  #     options hp-wmi force_fan_control_support=true
  #   '';
  # };
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
