{...}: {
  programs = {
    direnv.enable = true;
    partition-manager.enable = true;
    htop.enable = true;
    kdeconnect.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    gamemode.enable = true;
    gamescope.enable = true;
    zsh.enable = true;
  };
}
