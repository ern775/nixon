{
  config,
  pkgs,
  lib,
  ...
}:
let
  asus-wmi-leds-ids-patch = builtins.toFile "asus-wmi-leds-ids.patch" ''
    --- a/include/linux/platform_data/x86/asus-wmi.h	2026-01-09 12:01:29.459808110 +0300
    +++ b/include/linux/platform_data/x86/asus-wmi.h	2026-01-09 12:02:09.661618351 +0300
    @@ -223,6 +223,11 @@
     			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
     		},
     	},
    +	{
    +		.matches = {
    +			DMI_MATCH(DMI_BOARD_NAME, "FA608PP"),
    +		},
    +	},
     	{ },
     };
  '';
  kernel = config.boot.kernelPackages.kernel;
  fix-kbd-backlight = pkgs.stdenv.mkDerivation {
    pname = "fix-kbd-backlight";
    inherit (kernel)
      src
      version
      postPatch
      nativeBuildInputs
      ;

    kernel_dev = kernel.dev;
    kernelVersion = kernel.modDirVersion;

    modulePath = "drivers/platform/x86";

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
      description = "fix-kbd-backlight";
      license = lib.licenses.gpl2;
    };
  };
in
{
  boot.extraModulePackages = [
    (fix-kbd-backlight.overrideAttrs (_: {
      patches = [ asus-wmi-leds-ids-patch ];
    }))
  ];
}
