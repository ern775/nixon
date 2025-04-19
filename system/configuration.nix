{...}: {
  imports = [
    ./hardware-configuration.nix
    ./modules
    ./patches
  ];

  system.stateVersion = "24.11";
}
