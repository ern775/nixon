{
  inputs,
  pkgs,
  ...
}: let
  system = "x86_64-linux";
  pkgsStable = inputs.nixpkgsStable.legacyPackages.${system};
in {
  environment = {
    systemPackages = with pkgs; [
      alejandra
      cloudflare-warp
      exfatprogs
      git
      home-manager
      input-remapper
      kate
      lshw
      nixd
      nvtopPackages.full
      pciutils
      (python3.withPackages (p: with p; [pynvml]))
      p7zip
      rar
      steam-run
      sysfsutils
      undervolt
      xsettingsd
      xorg.xrdb
      wget
    ];
    plasma6.excludePackages = with pkgs.kdePackages; [
      khelpcenter
      plasma-browser-integration
      elisa
    ];
  };
}
