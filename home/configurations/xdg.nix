{ config, ... }:
{
  xdg = {
    enable = true;
    mime.enable = true;
    systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];
  };
}
