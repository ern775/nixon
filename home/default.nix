{...}: {
  imports = [
    ./user
    ./configurations
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "eren";
    homeDirectory = "/home/eren";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
