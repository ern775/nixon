{
  config,
  pkgs,
  lib,
  ...
}:
let
  mute-led-patch = builtins.toFile "mute-led.patch" ''
    --- a/sound/hda/codecs/realtek/alc269.c	2026-02-17 17:11:04.923083958 +0300
    +++ b/sound/hda/codecs/realtek/alc269.c	2026-02-17 17:19:55.503939333 +0300
    @@ -6609,6 +6609,7 @@
     	SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
     	SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
     	SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
    +	SND_PCI_QUIRK(0x103c, 0x8c75, "HP Omen 17-db0xxx", ALC285_FIXUP_HP_MUTE_LED),
     	SND_PCI_QUIRK(0x103c, 0x8c7b, "HP ProBook 445 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
     	SND_PCI_QUIRK(0x103c, 0x8c7c, "HP ProBook 445 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
     	SND_PCI_QUIRK(0x103c, 0x8c7d, "HP ProBook 465 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
  '';
  kernel = config.boot.kernelPackages.kernel;
  fix-mute-led = pkgs.stdenv.mkDerivation {
    pname = "mute-led";
    inherit (kernel)
      src
      version
      postPatch
      nativeBuildInputs
      ;

    kernel_dev = kernel.dev;
    kernelVersion = kernel.modDirVersion;

    modulePath = "sound/hda/codecs/realtek";

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
      description = "mute-led";
      license = lib.licenses.gpl2;
    };
  };
in
{
  boot.extraModulePackages = [
    (fix-mute-led.overrideAttrs (_: {
      patches = [ mute-led-patch ];
    }))
  ];
}
