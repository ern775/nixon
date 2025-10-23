{ pkgs, lib, ... }:
{
  services.mysql = {
    enable = true;
    package = pkgs.mysql80;
  };
  systemd.services.mysql.wantedBy = lib.mkForce [ ];
  environment.systemPackages = with pkgs; [ mysql-workbench ];
}
