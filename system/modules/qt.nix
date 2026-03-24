{ pkgs, ... }:
{
  # qt = {
  #   enable = true;
  #   style.name = "breeze";
  #   platformTheme = {
  #     name = "qt6ct";
  #   };
  # };
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5ct
    qt6Packages.qt6ct
  ];
  environment.sessionVariables = {
    # QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
