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
      home-manager switch -b backup && sudo nixos-rebuild switch
    ";
    fullRebuildBoot = "
      home-manager switch -b backup && sudo nixos-rebuild boot
    ";
    homeRebuild = "
      home-manager switch -b backup
    ";
    flakeUpdate = "nix flake update --flake ~/system";
    cpulow = ''
      sudo undervolt --turbo 1 -p1 10 5 -p2 15 1
    '';
    cpudef = ''
      sudo undervolt --turbo 1 -p1 35 5 -p2 45 1
    '';
    cpumid = ''
      sudo undervolt --turbo 0 -p1 35 5 -p2 35 1
    '';
    cpumax = ''
      sudo undervolt --turbo 0 -p1 100 5 -p2 100 1
    '';
    gpulow = ''
      sudo nvidia-smi -lgc 0,1680
      sudo nvidia-settings -c 0 -a 'GPUGraphicsClockOffsetAllPerformanceLevels'=255
    '';
    gpumid = ''
      sudo nvidia-smi -lgc 0,1995
      sudo nvidia-settings -c 0 -a 'GPUGraphicsClockOffsetAllPerformanceLevels'=240
    '';
    gpumax = ''
      sudo nvidia-smi -lgc 0,3360
      sudo nvidia-settings -c 0 -a 'GPUGraphicsClockOffsetAllPerformanceLevels'=240
    '';
    intelWatt = "sudo chmod o+r /sys/class/powercap/intel-rapl\:*/energy_uj";
    vesktop = "vesktop --proxy-server=socks5://127.0.0.1:1080";
    protonSymlinkUpdate = ''
      find ~/.local/share/Steam/compatibilitytools.d -type l \( -name "GE-Proton*" -o -name "DW-Proton" \) -delete
      TOOLS_PATHS=`steam-run printenv STEAM_EXTRA_COMPAT_TOOLS_PATHS`
      ln -sfn $TOOLS_PATHS[(ws[:])1] $HOME/.local/share/Steam/compatibilitytools.d/${pkgs.proton-ge-bin.version}
      ln -sfn $TOOLS_PATHS[(ws[:])1] $HOME/.local/share/Steam/compatibilitytools.d/GE-Proton
      ln -sfn $TOOLS_PATHS[(ws[:])3] $HOME/.local/share/Steam/compatibilitytools.d/DW-Proton
      unset TOOLS_PATHS
    '';
  };
in
{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = aliases;
      dotDir = "${config.xdg.configHome}/zsh";
      # zprof.enable = true;
      history = {
        expireDuplicatesFirst = true;
        ignoreAllDups = true;
        # ignoreDups = true;
        # saveNoDups = true;
        append = true;
        extended = true;
      };
      siteFunctions = {
        _warp-cli = builtins.readFile ./zsh/site-functions/_warp-cli;
      };
      # historySubstringSearch = {
      #   enable = true;
      #   searchUpKey = "^[OA";
      #   searchDownKey = "^[OB";
      # };
      plugins = [
        # {
        #   name = "fast-syntax-highlighting";
        #   src = pkgs.zsh-fast-syntax-highlighting;
        #   file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
        # }
        # {
        #   name = "zsh-autocomplete";
        #   src = pkgs.zsh-autocomplete;
        #   file = "share/zsh-autocomplete/zsh-autocomplete.plugin.zsh";
        # }
        {
          name = "zsh-nix-shell";
          src = pkgs.zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
      ];
      # oh-my-zsh = {
      #   enable = true;
      #   plugins = [
      #     # "history"
      #   ];
      # };
      localVariables = {
        DISABLE_AUTO_UPDATE = "true";
        DISABLE_MAGIC_FUNCTIONS = "true";
        DISABLE_COMPFIX = "true";
        ZSH_DISABLE_COMPFIX = "true";
      };
      initContent = ''
        setopt auto_pushd
        setopt interactive_comments
        setopt multios
        setopt noextended_glob # Breaks flake path reference nixpkgs#foo.

        source ${./zsh/async_prompt.zsh}
        source ${./zsh/completion.zsh}
        source ${./zsh/correction.zsh}
        source ${./zsh/key-bindings.zsh}

        typeset -gA FAST_HIGHLIGHT
        FAST_HIGHLIGHT[use_async]=1 # Improve paste delay for nix store paths.
      '';
    };
  };
}
