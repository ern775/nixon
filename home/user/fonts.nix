{ pkgs, ... }:
{
  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
  };

  home.packages = with pkgs; [
    ubuntu-classic
    unifont
    font-awesome
    noto-fonts-cjk-sans
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];
}
