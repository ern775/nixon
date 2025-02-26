{...}: {
  programs = {
    partition-manager.enable = true;
    kdeconnect.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    gamemode.enable = true;
    gamescope.enable = true;
    zsh.enable = true;
    thunar.enable = true;
  };
}
