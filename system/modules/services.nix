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
    gvfs.enable = true;
    logind = {
      settings.Login = {
        HandleLidSwitch = "ignore";
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
  };

  systemd.services.cloudflare-warp.serviceConfig.LogLevelMax = "notice"; # simply suppress all logs from warp
  # older cloudflare-warp version
  nixpkgs.overlays = [
    (final: prev: {
      cloudflare-warp = prev.cloudflare-warp.overrideAttrs (old: rec {
        version = "2025.10.186.0";
        src = pkgs.fetchurl {
          url = "https://pkg.cloudflareclient.com/pool/noble/main/c/cloudflare-warp/cloudflare-warp_${version}_amd64.deb";
          hash = "sha256-l+csDSBXRAFb2075ciCAlE0bS5F48mAIK/Bv1r3Q8GE=";
        };
      });
    })
  ];

  systemd.timers.fwupd-refresh.enable = false;
}
