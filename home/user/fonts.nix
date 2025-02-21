{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    noto-fonts
    ubuntu_font_family
    unifont
    noto-fonts-cjk-sans
    font-awesome
    nerd-fonts.noto
  ];
}
