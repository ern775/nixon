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
    byedpi = {
      enable = true;
      extraArgs = [
        "--disorder=1"
        "--tlsrec=1+s"
      ];
    };
    # zapret = {
    #   enable = true;
    #   httpSupport = false;
    #   params = [
    #     # eduroam - MSKU University
    #     "--dpi-desync=fake --dpi-desync-ttl=4 --new"
    #     # home wifi ttnet
    #     "--hostspell=hoSt"
    #     # "--dpi-desync=fakedsplit --dpi-desync-ttl=2 --orig-ttl=1 --orig-mod-start=s1 --orig-mod-cutoff=d1 --dpi-desync-split-pos=method+2 --dpi-desync-fakedsplit-mod=altorder=1"
    #   ];
    #   whitelist = [
    #     "discord.com"
    #     "gateway.discord.gg"
    #     "cdn.discordapp.com"
    #     # "discordapp.net"
    #     # "discordapp.com"
    #     "discord.gg"
    #     # "media.discordapp.net"
    #     # "images-ext-1.discordapp.net"
    #     # "discord.app"
    #     # "discord.media"
    #     # "discordcdn.com"
    #     # "discord.dev"
    #     # "discord.new"
    #     # "discord.gift"
    #     # "discordstatus.com"
    #     # "dis.gd"
    #     # "discord.co"
    #     # "discord-attachments-uploads-prd.storage.googleapis.com"
    #     # "discord.design"
    #     # "discord.gifts"
    #     # "discord.store"
    #     # "discord.status"
    #     # "discord-activities.com"
    #     # "discordactivities.com"
    #     # "discordmerch.com"
    #     # "discordpartygames.com"
    #     # "discordsays.com"
    #     # "discordsez.com"

    #     "nyaa.si"
    #     "nyaa.tracker.wf"
    #     "exodus.desync.com"
    #     "open.stealth.si"
    #     "tracker.opentrackr.org"
    #     "tracker.torrent.eu.org"
    #   ];
    # };
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
