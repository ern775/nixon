{ pkgs, ... }: {
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      antialias = true;
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = [ "Ubuntu" ];
        sansSerif = [ "Ubuntu" ];
        monospace = [ "Ubuntu Source" ];
      };
    };
  };
  fonts.packages = with pkgs; [
    corefonts
    font-awesome
    jetbrains-mono
    liberation_ttf
    material-symbols
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    roboto
    ubuntu-classic
    unifont
    work-sans
    nerd-fonts.jetbrains-mono
  ];
}
