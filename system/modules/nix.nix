{ inputs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  swapDevices = lib.mkForce [ ];

  console.keyMap = "trq";

  nix = {
    settings = {
      trusted-users = [
        "root"
        "eren"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # auto-optimise-store = true;
      # keep-outputs = false;
      # keep-derivations = false;
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos-cuda.org"
        "https://noctalia.cachix.org"
        "https://ern775-nixpkgs.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        "ern775-nixpkgs.cachix.org-1:TurFfb4SY0Reec+lLRhtafxyCLS/p9mfvoDMwtAKXrw="
      ];
    };
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
      "custom-nixpkgs=${inputs.custom-nixpkgs}"
    ];
    extraOptions = "warn-dirty = false";
  };
}
