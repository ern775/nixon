{ pkgs, ... }:
{
  services.usbmuxd.enable = true;
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    libimobiledevice
    nginx
  ];

  # services.samba = {
  #   enable = true;
  #   openFirewall = true;
  #   settings = {
  #     global = {
  #       "invalid users" = [
  #         "root"
  #       ];
  #       "passwd program" = "/run/wrappers/bin/passwd %u";
  #       "security" = "user";
  #       # "hosts allow" = "192.168.1. 10.241.173. 10.241.173. localhost";
  #       # "hosts deny" = "0.0.0.0/0";
  #     };
  #     shared = {
  #       "path" = "/home/casper/İndirilenler/";
  #       "browseable" = "yes";
  #       "writeable" = "yes";
  #       "read only" = "no";
  #       "guest ok" = "yes";
  #       "create mask" = "0771";
  #       "directory mask" = "0775";
  #       # NOTE: need to `sudo smbpasswd -a username` to be able to log in
  #       "force user" = "eren";
  #       "force group" = "users";
  #     };
  #   };
  # };

  services.nginx = {
    enable = true;
  };
}
