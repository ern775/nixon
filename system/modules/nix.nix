{inputs, ...}: {
  nixpkgs.config.allowUnfree = true;

  zramSwap.enable = true;

  console.keyMap = "trq";

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      keep-outputs = true;
      keep-derivations = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };
}
