{ pkgs, ... }:
{
  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
  };

  home.packages = with pkgs; [
    corefonts
    ubuntu-classic
    unifont
    font-awesome
    noto-fonts-cjk-sans
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    work-sans
  ];
}
