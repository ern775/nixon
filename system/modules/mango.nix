{ lib, inputs, ... }:
let
  mangobar = inputs.mangobar.packages.x86_64-linux.default;
in
{
  imports = [
    inputs.mangowm.nixosModules.mango
  ];
  programs.mango.enable = true;

  environment.systemPackages = [ mangobar ];

  systemd.user.services.mangobar = {
    enable = true;
    unitConfig = {
      Description = "mangobar Wayland status bar";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    serviceConfig = {
      ExecStart = lib.getExe mangobar;
      Restart = "on-failure";
      RestartSec = 3;
    };

    wantedBy = [ "graphical-session.target" ];
  };
}
