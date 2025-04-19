{inputs, secrets, ...}: {
  nixpkgs.config.allowUnfree = true;

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  console.keyMap = "trq";

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      keep-outputs = true;
      keep-derivations = true;
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
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    extraOptions = "access-tokens = github.com=${secrets.github_token}\n";
  };
}
