{...}: {
  imports = [
    ./user
  ];

  home.username = "eren";
  home.homeDirectory = "/home/eren";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
