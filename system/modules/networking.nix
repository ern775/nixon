{
  pkgs,
  config,
  lib,
  ...
}:
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
        43211
      ];
    };
  };
  services.openssh = {
    enable = true;
    ports = [ 49339 ];
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      # AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      KbdInteractiveAuthentication = false;
      GatewayPorts = "clientspecified";
      UsePAM = true;
      challengeResponseAuthentication = false;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDxHGhQag3zbvIfVdr56A1RUK8jWqmlXxdtYq9rObb/u nix-on-droid"
  ];
  users.users.eren.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDxHGhQag3zbvIfVdr56A1RUK8jWqmlXxdtYq9rObb/u nix-on-droid"
  ];
  services.fail2ban.enable = true;
  # systemd.services.sshd.wantedBy = lib.mkForce [ ];
  # services.zerotierone = {
  #   enable = true;
  #   joinNetworks = [ "68BEA79ACFDBC771" ];
  # };
  services.tailscale.enable = true;
  systemd.services.tailscaled = {
    after =
      # Order after NetworkManager-wait-online so an nm-online hang during a
      # NetworkManager restart can't stall nixos-rebuild mid-activation.
      # https://github.com/NixOS/nixpkgs/issues/180175
      lib.optional config.networking.networkmanager.enable "NetworkManager-wait-online.service"
      # Don't start until the network is online: otherwise tailscaled can claim
      # MagicDNS (100.100.100.100) before it can reach the control plane and
      # break DNS until it reconnects. Needs both `wants` and `after` — an
      # `after` edge alone won't pull the target into the boot transaction.
      # https://github.com/NixOS/nixpkgs/issues/527403
      ++ [ "network-online.target" ];
    wants = [ "network-online.target" ];
  };

  # services.open-webui = {
  #   enable = true;
  #   port = 8080;
  #   host = "0.0.0.0";
  #   openFirewall = true;

  #   environment = {
  #     OPENAI_API_BASE_URLS = "http://127.0.0.1:6931/v1";
  #     OPENAI_API_KEY = "none";

  #     # WEBUI_AUTH = "false";
  #   };
  # };
  # services.jellyfin = {
  #   enable = true;
  #   openFirewall = true;
  #   user = "eren";
  # };
  # services.qbittorrent = {
  #   enable = true;
  #   webuiPort = 40080;
  #   user = "eren";
  # };
  # services.prowlarr = {
  #   enable = true;
  #   openFirewall = true;
  # };
  # services.flaresolverr = {
  #   enable = true;
  #   openFirewall = true;
  # };
  # services.radarr = {
  #   enable = true;
  #   openFirewall = true;
  #   user = "eren";
  # };
  # systemd.services.radarr.serviceConfig.ProtectHome = lib.mkForce false;
  # services.sonarr = {
  #   enable = true;
  #   openFirewall = true;
  #   user = "eren";
  # };
  # systemd.services.sonarr.serviceConfig.ProtectHome = lib.mkForce false;
  # services.seerr = {
  #   enable = true;
  #   openFirewall = true;
  # };
}
