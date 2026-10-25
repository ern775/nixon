{ pkgs, inputs, ... }:
let
  system = "x86_64-linux";
  custom-nixpkgs = inputs.custom-nixpkgs.packages.${system};
in
{
  imports = [ inputs.tuxov.nixosModules.hp-wmi-control ];
  hardware.hp-wmi-control = {
    enable = true;
    # victus-15-support.enable = true;
  };
  # boot = {
  #   extraModulePackages = [
  #     custom-nixpkgs.hp-wmi-fan-and-backlight-control
  #   ];
  #   extraModprobeConfig = ''
  #     options hp-wmi force_fan_control_support=true
  #   '';
  # };
  environment.systemPackages = [ custom-nixpkgs.victus-control ];
  systemd = {
    packages = [
      custom-nixpkgs.victus-control
    ];
    # https://github.com/NixOS/nixpkgs/issues/81138
    services = {
      victus-backend.wantedBy = [ "multi-user.target" ];
    };
  };
}
