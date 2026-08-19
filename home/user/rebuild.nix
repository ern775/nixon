{ pkgs, ... }:
let
  full-rebuild-commit = pkgs.writeShellApplication {
    name = "full-rebuild-commit";

    runtimeInputs = with pkgs; [
      home-manager
      nixfmt-tree
      git
    ];

    text = ''
      set -e

      trap 'echo "Interrupted, aborting."; exit 1' INT

      pushd ~/system

      treefmt
      git diff --staged

      read -rp "Press Enter to continue..."

      echo "Rebuilding..."
      home-manager switch -b backup && sudo nixos-rebuild switch

      read -r gen date clock version _ <<< "$(nixos-rebuild list-generations | grep True)"
      gen_line="$gen $date $clock $version"

      read -rp "Commit message: " msg

      full_msg="''${msg:+$msg$'\n\n'}$gen_line"

      git commit -m "$full_msg"

      popd
    '';
  };
in
{
  home.packages = [
    full-rebuild-commit
  ];
}
