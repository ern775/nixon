{...}: let
  acpi_override = ./acpi_override;
in {
  boot.initrd.prepend = ["${acpi_override}"];
  boot.kernelParams = ["mem_sleep_default=deep"];
}
