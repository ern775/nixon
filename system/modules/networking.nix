{ pkgs, lib, ... }:
{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      plugins = with pkgs; [ networkmanager-openvpn ];
    };
    hosts = {
      "0.0.0.0" = [
        "overseauspider.yuanshen.com"
        "log-upload-os.hoyoverse.com"
        "log-upload-os.mihoyo.com"
        "dump.gamesafe.qq.com"

        "apm-log-upload-os.hoyoverse.com"
        "zzz-log-upload-os.hoyoverse.com"

        "log-upload.mihoyo.com"
        "devlog-upload.mihoyo.com"
        "uspider.yuanshen.com"
        "sg-public-data-api.hoyoverse.com"
        "hkrpg-log-upload-os.hoyoverse.com"
        "public-data-api.mihoyo.com"

        "prd-lender.cdp.internal.unity3d.com"
        "thind-prd-knob.data.ie.unity3d.com"
        "thind-gke-usc.prd.data.corp.unity3d.com"
        "cdp.cloud.unity3d.com"
        "remote-config-proxy-prd.uca.cloud.unity3d.com"

        "pc.crashsight.wetest.net"
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
}
