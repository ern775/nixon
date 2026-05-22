{ config, ... }:
{
  xdg =
    let
      link = config.lib.file.mkOutOfStoreSymlink;
    in
    {
      configFile =
        let
          configDir = "${config.home.homeDirectory}/system/home/dotfiles/.config";
        in
        {
          "MangoHud".source = link "${configDir}/MangoHud";
          "ZapZap".source = link "${configDir}/ZapZap";
          "hypr".source = link "${configDir}/hypr";
          "noctalia".source = link "${configDir}/noctalia";
          "qBittorrent".source = link "${configDir}/qBittorrent";

          "gpu-screen-recorder/config".source = link "${configDir}/gpu-screen-recorder/config";
          "Dopamine/config.json" = {
            source = link "${configDir}/Dopamine/config.json";
            force = true;
          };
          "ghb/preferences.json".source = link "${configDir}/ghb/preferences.json";
          "ghb/presets.json".source = link "${configDir}/ghb/presets.json";
          "MusicBrainz/Picard.ini".source = link "${configDir}/MusicBrainz/Picard.ini";
          "protonfixes/localfixes/default.py".source = link "${configDir}/protonfixes/localfixes/default.py";
          "vesktop/settings.json".source = link "${configDir}/vesktop/settings.json";
          "vesktop/settings/settings.json".source = link "${configDir}/vesktop/settings/settings.json";
          "vlc/vlcrc".source = link "${configDir}/vlc/vlcrc";
          "VSCodium/User/settings.json".source = link "${configDir}/VSCodium/User/settings.json";
          "VSCodium/User/keybindings.json".source = link "${configDir}/VSCodium/User/keybindings.json";
          "menus/applications.menu".source = link "${configDir}/menus/applications.menu";

          "dolphinrc".source = link "${configDir}/dolphinrc";
          "kactivitymanagerd-statsrc".source = link "${configDir}/kactivitymanagerd-statsrc";
          "kcminputrc".source = link "${configDir}/kcminputrc";
          "touchpadxlibinputrc".source = link "${configDir}/touchpadxlibinputrc";
          "color/icc/devices/display/Victus15.icm".source = link "${configDir}/color/icc/devices/display/Victus15.icm";
        };
    };
}
