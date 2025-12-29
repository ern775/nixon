{ pkgs, lib, ... }:
{
  services.mysql = {
    enable = true;
    package = pkgs.mysql80;
    settings = {
      mysqld = {
        datadir = "/var/lib/mysql";
        port = 3306;
        secure-file-priv = ''""'';
      };
    };
  };
  systemd.services.mysql.wantedBy = lib.mkForce [ ];
  environment.systemPackages = with pkgs; [ mysql-workbench ];
}
