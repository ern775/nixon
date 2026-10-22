{ pkgs, inputs, ... }:
let
  custom-nixpkgs = inputs.custom-nixpkgs.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  environment.systemPackages = with pkgs; [
    playerctl
    udiskie
    noctalia
    xwayland-satellite
    hicolor-icon-theme
    kdePackages.breeze-icons
    kdePackages.kirigami.unwrapped
  ];
  programs.niri = {
    enable = true;
    # useNautilus = true;
    package = custom-nixpkgs.niri-icclaude;
  };

  services.displayManager.defaultSession = "niri";

  services.udev.extraRules =
    let
      intelIgpuId = builtins.readFile (
        pkgs.runCommand "get-intel-igpu-id"
          {
            buildInputs = [ pkgs.pciutils ];
          }
          ''
            lspci -d ::03xx | grep 'Intel' | cut -f1 -d' ' | tr -d '\n' > $out
          ''
      );
      nvidiaGpuId = builtins.readFile (
        pkgs.runCommand "get-nvidia-gpu-id"
          {
            buildInputs = [ pkgs.pciutils ];
          }
          ''
            lspci -d ::03xx | grep 'NVIDIA' | cut -f1 -d' ' | tr -d '\n' > $out
          ''
      );
    in
    ''
      KERNEL=="card*", KERNELS=="0000:${intelIgpuId}", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/intel-igpu"
      KERNEL=="card*", KERNELS=="0000:${nvidiaGpuId}", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/nvidia-gpu"
    '';

  nix.settings = {
    substituters = [
      "https://noctalia.cachix.org"
    ];
    trusted-substituters = [
      "https://noctalia.cachix.org"
    ];
    trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  environment.pathsToLink = [
    "/share/icons"
    "/share/pixmaps"
  ];
}
