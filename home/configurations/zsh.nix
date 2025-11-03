{ pkgs, config, ... }:
let
  aliases = {
    cleanup = "
      sudo nix-collect-garbage -d
      nix-collect-garbage -d
    ";
    rebuild = "
      sudo nixos-rebuild switch
    ";
    rebuildBoot = "
      sudo nixos-rebuild boot
    ";
    fullRebuild = "
      sudo nixos-rebuild switch
      home-manager switch -b backup
    ";
    fullRebuildBoot = "
      sudo nixos-rebuild boot
      home-manager switch -b backup
    ";
    homeRebuild = "
      home-manager switch -b backup
    ";
    flakeUpdate = "nix flake update --flake ~/system";
    switchDefault = "
      sudo nix-shell ~/system/scripts/nvidia-oc-low-power.nix
      sudo undervolt --turbo 1 -p1 35 5 -p2 45 1
    ";
    switchGame = "
      sudo nix-shell ~/system/scripts/nvidia-oc-low-power.nix
      sudo undervolt --turbo 0 -p1 35 5 -p2 35 1
    ";
    switchPerformance = "
      sudo nix-shell ~/system/scripts/nvidia-oc-high-power.nix
      sudo undervolt --turbo 0 -p1 35 5 -p2 35 1
    ";
    switchVideo = "
      sudo nix-shell ~/system/scripts/nvidia-oc-high-power.nix
      sudo undervolt --turbo 1 -p1 35 5 -p2 45 1
    ";
    switchNovideo = "
      sudo nix-shell ~/system/scripts/nvidia-oc-max-power.nix
      sudo undervolt --turbo 1 -p1 35 5 -p2 45 1
    ";
    switchMax = "
      sudo nix-shell ~/system/scripts/nvidia-oc-max-power.nix
      sudo undervolt --turbo 0 -p1 100 5 -p2 100 1
    ";
    switchBattery = "
      sudo undervolt --turbo 1 -p1 10 5 -p2 15 1
    ";
    intelWatt = "sudo chmod o+r /sys/class/powercap/intel-rapl\:*/energy_uj";
    umu = "PROTONPATH=GE-Proton umu-run";
    vesktop = "vesktop --proxy-server=socks5://127.0.0.1:1080";
    protonSymlinkUpdate = ''
      find ~/.local/share/Steam/compatibilitytools.d -type l \( -name "GE-Proton" -o -name "Proton-Spritz" -o -name "${pkgs.proton-ge-bin.version}" \) -delete
      ln -sfn `steam-run printenv STEAM_EXTRA_COMPAT_TOOLS_PATHS | sed 's/:.*//'` $HOME/.local/share/Steam/compatibilitytools.d/${pkgs.proton-ge-bin.version}
      ln -sfn `steam-run printenv STEAM_EXTRA_COMPAT_TOOLS_PATHS | sed 's/:.*//'` $HOME/.local/share/Steam/compatibilitytools.d/GE-Proton
      ln -sfn `steam-run printenv STEAM_EXTRA_COMPAT_TOOLS_PATHS | sed 's/.*://'` $HOME/.local/share/Steam/compatibilitytools.d/Proton-Spritz
    '';
    sshCasper = "ssh casper@10.241.173.250";
  };
in
{
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = aliases;
      dotDir = "${config.xdg.configHome}/zsh";
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
