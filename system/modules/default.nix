{ ... }:
{
  imports = [
    ./audio.nix
    ./boot.nix
    ./display.nix
    ./fonts.nix
    ./nix.nix
    ./hardware.nix
    ./hp-fan-control.nix
    ./hp.nix
    # ./hyprland.nix
    ./intel.nix
    ./internationalisation.nix
    # ./ios.nix
    ./journal.nix
    # ./nbfc.nix
    ./network.nix
    ./networking.nix
    ./packages.nix
    ./plasma.nix
    ./programs.nix
    ./services.nix
    # ./stylix.nix
    ./sudo.nix
    ./systemd.nix
    ./users.nix
    # ./virtualisation.nix
    # ./webdav.nix

    ./mysql.nix
    ./network.nix
  ];
}
