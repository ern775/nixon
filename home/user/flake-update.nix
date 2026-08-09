{ pkgs, ... }:
let
  flake-update-commit = pkgs.writeShellApplication {
    name = "flake-update-commit";

    runtimeInputs = with pkgs; [
      git
    ];

    text = ''
      set -e

      pushd ~/system

      changes_file=/tmp/flake-changes

      echo "Updating flake inputs..."
      nix flake update 2>&1 | tee "$changes_file"

      grep -A 2 '^•' "$changes_file" > "$changes_file.tmp" || true
      mv "$changes_file.tmp" "$changes_file"

      git add flake.lock flake.nix

      date_line="$(date '+%Y-%m-%d %H:%M:%S')"
      commit_msg="$(printf 'flake update (%s)\n\n%s' "$date_line" "$(cat "$changes_file")")"

      git diff --staged --quiet && echo "No changes to commit."
      git diff --staged --quiet || git commit -m "$commit_msg"

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
