{ pkgs, ... }:
let
  diff-gens = pkgs.writeShellApplication {
    name = "diff-gens";

    text = ''
      SYSTEM_DIR="/nix/var/nix/profiles"
      HM_DIR="$HOME/.local/state/nix/profiles"

      latest_two() {
          local dir="$1" prefix="$2"
          local nums=()
          for f in "$dir/$prefix"-*-link; do
              [ -e "$f" ] || continue
              n="''${f#"$dir/$prefix"-}"
              n="''${n%-link}"
              nums+=("$n")
          done
          printf '%s\n' "''${nums[@]}" | sort -n | tail -2
      }

      echo "=== NixOS system generations ==="
      mapfile -t gens < <(latest_two "$SYSTEM_DIR" system)
      nix store diff-closures "$SYSTEM_DIR/system-''${gens[0]}-link" "$SYSTEM_DIR/system-''${gens[1]}-link"

      echo
      echo "=== home-manager generations ==="
      mapfile -t gens < <(latest_two "$HM_DIR" home-manager)
      nix store diff-closures "$HM_DIR/home-manager-''${gens[0]}-link" "$HM_DIR/home-manager-''${gens[1]}-link"
    '';
  };
in
{
  home.packages = [
    diff-gens
  ];
}
