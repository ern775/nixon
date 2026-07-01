{ pkgs, ... }:
{
  # services.usbmuxd.enable = true;
  # virtualisation.docker.enable = true;
  # environment.systemPackages = with pkgs; [
  #   libimobiledevice
  #   nginx
  # ];
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        # "invalid users" = [
        #   "root"
        # ];
        # "passwd program" = "/run/wrappers/bin/passwd %u";
        # "security" = "user";
        # "hosts allow" = "192.168.1. 10.241.173. 10.241.173. localhost";
        # "hosts deny" = "0.0.0.0/0";
        # "map to guest" = "Bad User";
      };
      shared = {
        "path" = "/home/eren/Projects/ErbakırStaj/Stajyer";
        "browseable" = "yes";
        "writeable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0777";
        # "directory mask" = "0775";
        # NOTE: need to `sudo smbpasswd -a username` to be able to log in
        "force user" = "eren";
        "force group" = "users";
      };
    };
  };

  users.users.eren = {
    isNormalUser = true;
    extraGroups = [ "samba" ];
  };

  # services.nginx = {
  #   enable = true;
  # };
}
