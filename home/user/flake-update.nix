{ pkgs, ... }:
let
  flake-update-commit = pkgs.writeShellApplication {
    name = "flake-update-commit";

    runtimeInputs = with pkgs; [
      git
      home-manager
    ];

    text = ''
      cd ~/system

      trap 'git checkout -- flake.lock' ERR INT TERM

      nix flake update

      if git diff --quiet -- flake.lock; then
        echo "No flake changes"
        exit 0
      fi

      home-manager switch -b backup
      sudo nixos-rebuild boot

      git add flake.lock
      git commit -m "flake update $(date '+%Y-%m-%d %H:%M:%S')"
    '';
  };
in
{
  home.packages = [
    flake-update-commit
  ];
}
