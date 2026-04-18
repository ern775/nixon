{
  systemd.coredump.settings.Coredump.Storage = "none";
  services.journald.extraConfig = "SystemMaxUse=100M";
}
