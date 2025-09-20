{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [ (python3.withPackages (p: with p; [ pynvml ])) ];

  shellHook = ''
    python3 /home/eren/system/scripts/nvidia-oc-low-power.py
    exit
  '';
}
