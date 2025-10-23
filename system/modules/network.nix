{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ciscoPacketTracer8
    wireshark-qt
  ];
  programs.wireshark = {
    enable = true;
  };
}
