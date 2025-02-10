{
  systemd.coredump.extraConfig = "Storage=none";
  services.journald.extraConfig = "SystemMaxUse=100M";
}