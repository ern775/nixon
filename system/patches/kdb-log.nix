{
  config,
  pkgs,
  lib,
  ...
}:
let
  hid-asus-patch = builtins.toFile "hid-asus.patch" ''
    --- a/drivers/hid/hid-asus.c	2026-01-09 13:26:28.072099425 +0300
    +++ b/drivers/hid/hid-asus.c	2026-01-09 13:32:31.735390258 +0300
    @@ -521,11 +521,9 @@
     	u32 value;
     	int ret;
     
    -	if (!IS_ENABLED(CONFIG_ASUS_WMI))
    -		return false;
    +	hid_info(hdev, "drvdata->quirks = %s, QUIRK_ROG_NKEY_KEYBOARD = %s \n", drvdata->quirks, QUIRK_ROG_NKEY_KEYBOARD);
     
    -	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD &&
    -			dmi_check_system(asus_use_hid_led_dmi_ids)) {
    +	if (dmi_check_system(asus_use_hid_led_dmi_ids)) {
     		hid_info(hdev, "using HID for asus::kbd_backlight\n");
     		return false;
     	}
  '';
  kernel = config.boot.kernelPackages.kernel;
  kbd-log = pkgs.stdenv.mkDerivation {
    pname = "kbd-log";
    inherit (kernel)
      src
      version
      postPatch
      nativeBuildInputs
      ;

    kernel_dev = kernel.dev;
    kernelVersion = kernel.modDirVersion;

    modulePath = "drivers/hid";

    buildPhase = ''
      BUILT_KERNEL=$kernel_dev/lib/modules/$kernelVersion/build

      cp $BUILT_KERNEL/Module.symvers .
      cp $BUILT_KERNEL/.config        .
      cp $kernel_dev/vmlinux          .

      make "-j$NIX_BUILD_CORES" modules_prepare
      make "-j$NIX_BUILD_CORES" M=$modulePath modules
    '';

    installPhase = ''
      make \
        INSTALL_MOD_PATH="$out" \
        XZ="xz -T$NIX_BUILD_CORES" \
        M="$modulePath" \
        modules_install
    '';

    meta = {
      description = "kbd-log";
      license = lib.licenses.gpl2;
    };
  };
in
{
  boot.extraModulePackages = [
    (kbd-log.overrideAttrs (_: {
      patches = [ hid-asus-patch ];
    }))
  ];
}
