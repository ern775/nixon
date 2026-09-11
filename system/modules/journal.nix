{
  systemd.coredump.settings.Coredump.Storage = "none";
  services.journald.settings.Journal = {
    SystemMaxUse = "100M";
  };
}
