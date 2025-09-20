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
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      # keep-outputs = false;
      # keep-derivations = false;
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
        "https://ezkea.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      ];
      trusted-substituters = [
        "http://cache.nixos.org"
        "https://hydra.nixos.org/"
      ];
    };
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    extraOptions = "warn-dirty = false";
  };
}
