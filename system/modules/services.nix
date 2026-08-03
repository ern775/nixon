{ pkgs, inputs, ... }:
{
  services = {
    fwupd.enable = true;
    # system76-scheduler.enable = true;
    # printing = {
    #   enable = true;
    #   # drivers = with pkgs; [
    #   #   canon-capt
    #   # ];
    # };
    cloudflare-warp = {
      enable = true;
      openFirewall = true;
      package = (pkgs.cloudflare-warp.override { headless = true; }); # disable warp-taskbar
    };
    # input-remapper.enable = true;
    # gvfs.enable = true;
    logind = {
      settings.Login = {
        HandleLidSwitch = "ignore";
        # HandlePowerKey = "suspend";
        KillUserProcesses = false;
      };
    };
    orca.enable = false;
    dbus.implementation = "broker";
    # byedpi = {
    #   enable = true;
    #   extraArgs = [
    #     "--split=1"
    #     "--disorder=3+s"
    #     "--mod-http=h,d"
    #     "--auto=torst"
    #     "--tlsrec=1+s"
    #   ];
    # };
    zapret = {
      enable = true;
      configureFirewall = true;
      httpSupport = false;
      udpSupport = true;
      udpPorts = [
        "19294:19344"
        "50000:65535"
      ];
      params = [
        # # eduroam - MSKU University
        # "--dpi-desync=fake --dpi-desync-ttl=4 --new"

        # # home wifi ttnet
        "--dpi-desync=fake"
        "--dpi-desync-ttl=3"
        "--dpi-desync-fooling=md5sig"
        "--dpi-desync-any-protocol"
      ];
      whitelist = [
        "discord.com"
        "discordapp.com"
        "discordapp.net"
        "discord.gg"
        "discord.media"
        "discord.gift"
        "discord.gifts"
        "discord.new"
        "discord.store"
        "discord.tools"
        "discord.dev"
        "discordstatus.com"
        "discordactivities.com"
        "discord-activities.com"
        "discordsays.com"
        "discordsez.com"
        "discordpartygames.com"
        "dis.gd"

        # "nyaa.si"
        # "nyaa.tracker.wf"
        # "exodus.desync.com"
        # "open.stealth.si"
        # "tracker.opentrackr.org"
        # "tracker.torrent.eu.org"
      ];
    };
  };

  systemd.services.cloudflare-warp.serviceConfig.LogLevelMax = "notice"; # simply suppress all logs from warp
  # older cloudflare-warp version
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     cloudflare-warp = prev.cloudflare-warp.overrideAttrs (old: rec {
  #       version = "2025.9.558.0";
  #       src = pkgs.fetchurl {
  #         url = "https://pkg.cloudflareclient.com/pool/noble/main/c/cloudflare-warp/cloudflare-warp_${version}_amd64.deb";
  #         hash = "sha256-eYPy8YnP/vvYmvvjvF6Y0gSzdglsvoPW6CJ5npjrtpo=";
  #       };
  #     });
  #   })
  # ];

  systemd.timers.fwupd-refresh.enable = false;

  # kill konqi
  systemd.coredump.enable = true;
  systemd.services."drkonqi-coredump-processor@".enable = false;
  systemd.user.services."drkonqi-coredump-launcher@".enable = false;
  systemd.user.services."drkonqi-coredump-pickup".enable = false;
  systemd.user.services."drkonqi-coredump-cleanup".enable = false;
  systemd.user.services."drkonqi-sentry-postman".enable = false;
  systemd.user.sockets."drkonqi-coredump-launcher".enable = false;
  systemd.user.paths."drkonqi-sentry-postman".enable = false;
  systemd.user.timers."drkonqi-coredump-cleanup".enable = false;
  systemd.user.timers."drkonqi-sentry-postman".enable = false;
}
