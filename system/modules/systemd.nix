{
  pkgs,
  inputs,
  ...
}: {
  systemd = {
    coredump.extraConfig = "Storage=none";
    services = {
      novideo = {
        enable = true;
        script = ''
          ${pkgs.nix}/bin/nix-shell -I nixpkgs=${inputs.nixpkgs} /home/eren/system/scripts/nvidia-oc-low-power.nix
        '';
        wantedBy = ["multi-user.target"];
        serviceConfig = {
          Type = "oneshot";
        };
      };
    };
  };
}
