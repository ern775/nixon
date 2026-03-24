{ pkgs, ... }:
{
  # qt = {
  #   enable = true;
  #   kde.settings = {
  #     kdeglobals = {
  #       Icons.Theme = iconTheme;
  #       KDE.widgetStyle = cfg.style.name;
  #     };
  #   };
  # };
  # home.packages = with pkgs; [
  #   libsForQt5.qt5ct
  #   qt6Packages.qt6ct
  # ];
  # home.sessionVariables = { QT_QPA_PLATFORMTHEME = "qt6ct"; };
}
