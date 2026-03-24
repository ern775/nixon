{ ... }:
{
  imports = [
    ./user
    ./configurations
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "eren";
    homeDirectory = "/home/eren";
    stateVersion = "26.05";
    shell.enableShellIntegration = true;
  };

  programs.home-manager.enable = true;
}
