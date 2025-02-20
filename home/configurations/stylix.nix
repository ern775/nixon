{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.stylix.homeManagerModules.stylix];

  home.packages = with pkgs; [
    bibata-cursors
    noto-fonts
    noto-fonts-emoji
    jetbrains-mono
    base16-schemes
  ];

  gtk.enable = true;
  qt.enable = true;
  xsession.enable = true;

  stylix = {
    enable = true;

    autoEnable = false;

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-dark.yaml";

    image = ../images/gruvbox-dark-blue.png;

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 22;
    };

    fonts = {
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Emoji";
      };
      monospace = {
        name = "JetBrains Mono";
        package = pkgs.jetbrains-mono;
      };
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };

      sizes = {
        terminal = 10;
        applications = 10;
      };
    };

    targets = {
      vscode.enable = false;
      librewolf.enable = false;
      cava.enable = true;
      gtk.enable = true;
      mangohud.enable = false;
      qt.enable = false;
      vesktop.enable = true;
      xresources.enable = true;
      kitty.enable = true;
    };
  };
}
