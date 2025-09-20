{ pkgs, ... }:
{
  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
  };

  home.packages = with pkgs; [
    noto-fonts
    ubuntu_font_family
    unifont
    noto-fonts-cjk-sans
    font-awesome
    jetbrains-mono
    noto-fonts-color-emoji
  ];
}
