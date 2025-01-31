{...}: {
  xdg = {
    desktopEntries = {
      jdownloader = {
        name = "Jdownloader";
        comment = "Download Manager";
        exec = "java -jar /home/eren/Tools/Jdownloader/JDownloader.jar";
        terminal = false;
        type = "Application";
        icon = "/home/eren/Tools/Jdownloader/trazo.png";
      };
    };
  };
}
