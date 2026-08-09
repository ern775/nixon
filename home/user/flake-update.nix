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

      pushd ~/system

      changes_file=/tmp/flake-changes

      echo "Updating flake inputs..."
      nix flake update 2>&1 | tee "$changes_file"

      grep -A 2 '^•' "$changes_file" > "$changes_file.tmp" || true
      mv "$changes_file.tmp" "$changes_file"

      git diff --quiet -- flake.lock flake.nix && echo "No flake changes, skipping rebuild and commit."
      git diff --quiet -- flake.lock flake.nix || {
        echo "Rebuilding..."
        home-manager switch -b backup && sudo /run/current-system/sw/bin/nixos-rebuild switch

        git add flake.lock flake.nix

        date_line="$(date '+%Y-%m-%d %H:%M:%S')"
        commit_msg="$(printf 'flake update %s\n\n%s' "$date_line" "$(cat "$changes_file")")"

        git commit -m "$commit_msg"
      }

      rm -f "$changes_file"

      popd
    '';
  };
in
{
  home.packages = [
    flake-update-commit
  ];
}
