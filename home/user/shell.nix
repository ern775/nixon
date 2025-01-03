{...}: let
  myAliases = {
    cleanup = ''
      sudo nix-collect-garbage -d
      nix-collect-garbage -d
    '';
    rebuild = "sudo nixos-rebuild switch --flake ~/system";
    rebuildBoot = "sudo nixos-rebuild boot --flake ~/system";
    fullRebuild = "sudo nixos-rebuild switch --flake ~/system && rm -f .gtkrc-2.0.backup && home-manager switch --flake ~/system -b backup";
    fullRebuildBoot = "sudo nixos-rebuild boot --flake ~/system && rm -f .gtkrc-2.0.backup && home-manager switch --flake ~/system -b backup";
    homeRebuild = "rm -f .gtkrc-2.0.backup && home-manager switch --flake ~/system -b backup";
    flakeUpdate  = "sudo nix flake update --flake ~/system";
    switchP = ''
      sudo nix-shell ~/system/scripts/nvidia-oc-high-power.nix
      sudo undervolt --turbo 0 -p1 35 5 -p2 45 1
    '';
    switchE = ''
      sudo nix-shell ~/system/scripts/nvidia-oc-low-power.nix
      sudo undervolt --turbo 1 -p1 35 5 -p2 45 1
    '';
    switchB = ''
      sudo nix-shell ~/system/scripts/nvidia-oc-low-power.nix
      sudo undervolt --turbo 1 -p1 10 5 -p2 15 1
    '';
    switchG = ''
      sudo nix-shell ~/system/scripts/nvidia-oc-low-power.nix
      sudo undervolt --turbo 0 -p1 35 5 -p2 45 1
    '';
    intelWatt = "sudo chmod o+r /sys/class/powercap/intel-rapl\:0/energy_uj";
  };
in {
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = myAliases;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "history"
          "wd"
        ];
      };
    };
  };
}
