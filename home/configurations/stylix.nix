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

  stylix = {
    enable = true;

    autoEnable = true;

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-terminal-dark.yaml";

    image = ../images/gruvbox-dark-blue.png;

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
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
        applications = 10;
        desktop = 8;
        popups = 8;
        terminal = 10;
      };
    };

    targets = {
      vscode.enable = false;
      librewolf.enable = true;
      cava.enable = true;
      gtk.enable = true;
      mangohud.enable = false;
      qt.enable = false;
      vesktop.enable = true;
      xresources.enable = false;
      kitty.enable = true;
      hyprland.enable = true;
      wpaperd.enable = false;
      hyprpaper.enable = true;
    };
  };
}
