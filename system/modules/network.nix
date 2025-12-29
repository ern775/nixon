{ pkgs, ... }:
let
  cisco = (
    pkgs.symlinkJoin {
      name = "packettracer";
      buildInputs = [ pkgs.makeWrapper ];
      paths = [ pkgs.ciscoPacketTracer8 ];
      postBuild = ''
        wrapProgram $out/bin/packettracer8 \
          --set XDG_CURRENT_DESKTOP "GNOME"
      '';
    }
  );
in
{
  environment.systemPackages = [
    cisco
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "ciscoPacketTracer8-8.2.2"
  ];
}
