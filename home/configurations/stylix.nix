{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.stylix.homeManagerModules.stylix];

  home.packages = with pkgs; [
    vanilla-dmz
    noto-fonts
    noto-fonts-emoji
    jetbrains-mono
  ];

  stylix = {
    enable = true;

    autoEnable = false;

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-dark.yaml";

    image = pkgs.fetchurl {
      url = "https://codeberg.org/lunik1/nixos-logo-gruvbox-wallpaper/raw/branch/master/png/gruvbox-dark-blue.png";
      sha256 = "fa37d3baf975549a1c37e60da74e1854e351d39e065fea7fcb1357cb286c35cb";
    };

    cursor = {
      name = "DMZ-Black";
      package = pkgs.vanilla-dmz;
      size = 24;
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
    };
  };
}
