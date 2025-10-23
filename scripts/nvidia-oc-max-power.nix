{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [ python3Packages.nvidia-ml-py ];

  shellHook = ''
    python3 /home/eren/system/scripts/nvidia-oc-max-power.py
    exit
  '';
}
