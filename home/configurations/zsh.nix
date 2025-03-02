{...}: let
  aliases = {
    cleanup = "
      sudo nix-collect-garbage -d
      nix-collect-garbage -d
    ";
    rebuild = "sudo nixos-rebuild switch";
    rebuildBoot = "sudo nixos-rebuild boot";
    fullRebuild = "sudo nixos-rebuild switch && rm -f ~/.config/gtk-2.0/gtkrc.backup && home-manager switch -b backup";
    fullRebuildBoot = "sudo nixos-rebuild boot && rm -f ~/.config/gtk-2.0/gtkrc.backup && home-manager switch -b backup";
    homeRebuild = "rm -f ~/.config/gtk-2.0/gtkrc.backup && home-manager switch -b backup";
    flakeUpdate = "sudo nix flake update --flake ~/system";
    switchP = "
      sudo nix-shell ~/system/scripts/nvidia-oc-high-power.nix
      sudo undervolt --turbo 0 -p1 35 5 -p2 45 1
    ";
    switchV = "
      sudo nix-shell ~/system/scripts/nvidia-oc-high-power.nix
      sudo undervolt --turbo 1 -p1 35 5 -p2 45 1
    ";
    switchE = "
      sudo nix-shell ~/system/scripts/nvidia-oc-low-power.nix
      sudo undervolt --turbo 1 -p1 35 5 -p2 45 1
    ";
    switchB = "
      sudo nix-shell ~/system/scripts/nvidia-oc-low-power.nix
      sudo undervolt --turbo 1 -p1 10 5 -p2 15 1
    ";
    switchG = "
      sudo nix-shell ~/system/scripts/nvidia-oc-low-power.nix
      sudo undervolt --turbo 0 -p1 35 5 -p2 45 1
    ";
    switchM = "
      sudo nix-shell ~/system/scripts/nvidia-oc-max-power.nix
      sudo undervolt --turbo 0 -p1 50 5 -p2 55 1
    ";
    switchN = "
      sudo nix-shell ~/system/scripts/nvidia-oc-max-power.nix
      sudo undervolt --turbo 1 -p1 35 5 -p2 45 1
    ";
    intelWatt = "sudo chmod o+r /sys/class/powercap/intel-rapl\:0/energy_uj";
  };
in {
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = aliases;
      dotDir = ".config/zsh";
      history = {
        expireDuplicatesFirst = true;
        ignoreAllDups = true;
        ignoreDups = true;
        saveNoDups = true;
        append = true;
      };
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
