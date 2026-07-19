{
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.stylix.homeModules.stylix ];

  home.pointerCursor.enable = true;

  stylix = {
    enable = true;

    autoEnable = false;

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-terminal-dark.yaml";

    image = ../images/gruvbox-dark-blue.png;

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
    };

    # icons = {
    #   enable = true;
    #   package = pkgs.kdePackages.breeze-icons;
    #   dark = "Breeze-Dark";
    #   light = "Breeze";
    # };

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
      vscode.enable = false;
      # librewolf.enable = false;
      # librewolf.profileNames = [ "Default" ];
      cava.enable = true;
      gtk.enable = true;
      mangohud.enable = false;
      qt.enable = false;
      # qt.platform = "qtct";
      vencord.enable = true;
      vesktop.enable = true;
      xresources.enable = true;
      kitty.enable = true;
      hyprland.enable = false;
      hyprland.hyprpaper.enable = false;
      hyprpaper.enable = false;
      hyprlock.enable = false;
      hyprlock.image.enable = false;
      hyprpanel.enable = false;
      waybar.enable = false;
      kde.enable = false;
      mako.enable = true;
      gnome.enable = false;
    };
  };
}
