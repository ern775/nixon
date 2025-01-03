{
  imports = [
    ./cursor.nix
    ./environment.nix
    ./git.nix
    ./shell.nix
    ./packages.nix
    ./xdg.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
