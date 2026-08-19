{ pkgs, ... }:
let
  flake-update-commit = pkgs.writeShellApplication {
    name = "flake-update-commit";

    runtimeInputs = with pkgs; [
      git
      home-manager
    ];

    text = ''
      set -e

      trap 'echo "Interrupted, aborting."; exit 1' INT

      pushd ~/system

      echo "Updating flake inputs..."
      nix flake update

      if git diff --quiet -- flake.lock flake.nix; then
        echo "No flake changes, skipping rebuild and commit."
      else
        echo "Rebuilding..."
        home-manager switch -b backup && sudo nixos-rebuild switch

        git add flake.lock flake.nix
        git commit -m "flake update $(date '+%Y-%m-%d %H:%M:%S')"
      fi

      popd
    '';
  };
in
{
  home.packages = [
    flake-update-commit
  ];
}
