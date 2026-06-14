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
    firewall = {
      enable = true;
      allowedTCPPorts = [
        6931
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
  # services.zerotierone = {
  #   enable = true;
  #   joinNetworks = [ "68BEA79ACFDBC771" ];
  # };
  services.tailscale.enable = true;

  services.open-webui = {
    enable = true;
    port = 8080;
    host = "0.0.0.0"; # reachable from phone on same network
    openFirewall = true; # poke the hole in the firewall automatically

    environment = {
      # point at your llama-server
      OPENAI_API_BASE_URLS = "http://127.0.0.1:6931/v1";
      OPENAI_API_KEY = "none"; # llama-server doesn't need a real key

      # for a home setup, disable login entirely
      # WEBUI_AUTH = "false";
    };
  };
}
