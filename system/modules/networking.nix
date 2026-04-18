{ pkgs, lib, ... }:
{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      plugins = with pkgs; [ networkmanager-openvpn ];
    };
    # proxy = {
    #   default = "socks5h://127.0.0.1:1080";
    #   noProxy = "127.0.0.1,localhost";
    # };
    hosts = {
      "0.0.0.0" = [
        "log-upload-os.hoyoverse.com"
        "overseauspider.yuanshen.com"
        "apm-log-upload-os.hoyoverse.com"
        "zzz-log-upload-os.hoyoverse.com"
      ];
    };
  };
  # services.openssh = {
  #   enable = true;
  #   ports = [ 22 ];
  #   openFirewall = true;
  #   settings = {
  #     PasswordAuthentication = true;
  #     # AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
  #     UseDns = true;
  #     X11Forwarding = false;
  #     PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
  #   };
  # };
  # services.fail2ban.enable = true;
  # systemd.services.sshd.wantedBy = lib.mkForce [ ];
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "68BEA79ACFDBC771" ];
  };
  services.tailscale.enable = true;
}
