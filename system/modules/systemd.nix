{
  pkgs,
  inputs,
  ...
}:
{
  systemd = {
    services = {
      novideo = {
        script = ''
          ${pkgs.nix}/bin/nix-shell -I nixpkgs=${inputs.nixpkgs} /home/eren/system/scripts/nvidia-oc-low-power.nix
        '';
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
        };
      };
      byedpi = {
        script = ''
          ${pkgs.byedpi}/bin/ciadpi -r 1+s
        '';
        wantedBy = ["default.target"];
      };
    };
  };
}
