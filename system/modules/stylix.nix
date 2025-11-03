{ pkgs, ... }:
{
  stylix = {
    enable = true;

    autoEnable = true;

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-terminal-dark.yaml";

    image = ../../home/images/gruvbox-dark-blue.png;

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
    };

    fonts = {
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
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
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 10;
      };
    };

    targets = {
      gtk.enable = true;
      qt.enable = false;
      gnome.enable = false;
    };
  };
}
