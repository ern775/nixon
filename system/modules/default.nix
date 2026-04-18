{ ... }:
{
  imports = [
    ./audio-mic-boost-fix.nix
    ./audio.nix
    ./boot.nix
    # ./cachyos-kernel.nix
    ./display.nix
    ./fonts.nix
    ./nix.nix
    ./hardware.nix
    ./hp-fan-control.nix
    ./hp.nix
    ./hyprland.nix
    ./intel.nix
    ./internationalisation.nix
    # ./ios.nix
    ./journal.nix
    # ./nbfc.nix
    ./networking.nix
    ./packages.nix
    # ./plasma.nix
    ./programs.nix
    # ./qt.nix
    ./services.nix
    # ./stylix.nix
    ./sudo.nix
    ./systemd.nix
    ./users.nix
    # ./virtualisation.nix
    # ./webdav.nix

    # ./silent-boot.nix
    # ./mysql.nix
    # ./network.nix
    # ./pihole.nix
  ];
}
