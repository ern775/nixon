{
  config,
  pkgs,
  lib,
  ...
}:
let
  alc269-patch = builtins.toFile "alc269.patch" ''
    --- linux-6.17*/sound/hda/codecs/realtek/alc269.c.orig	2025-10-09 16:00:42.882575112 +0300
    +++ linux-6.17*/sound/hda/codecs/realtek/alc269.c	2025-10-09 16:02:13.203842003 +0300
    @@ -6548,7 +6548,7 @@
     	SND_PCI_QUIRK(0x103c, 0x8bb3, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
     	SND_PCI_QUIRK(0x103c, 0x8bb4, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
     	SND_PCI_QUIRK(0x103c, 0x8bbe, "HP Victus 16-r0xxx (MB 8BBE)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
    -	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
    +	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx (MB 8BC8)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
     	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
     	SND_PCI_QUIRK(0x103c, 0x8bd4, "HP Victus 16-s0xxx (MB 8BD4)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
     	SND_PCI_QUIRK(0x103c, 0x8bdd, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
    @@ -6568,6 +6568,7 @@
     	SND_PCI_QUIRK(0x103c, 0x8c16, "HP Spectre x360 2-in-1 Laptop 16-aa0xxx", ALC245_FIXUP_HP_SPECTRE_X360_16_AA0XXX),
     	SND_PCI_QUIRK(0x103c, 0x8c17, "HP Spectre 16", ALC287_FIXUP_CS35L41_I2C_2),
     	SND_PCI_QUIRK(0x103c, 0x8c21, "HP Pavilion Plus Laptop 14-ey0XXX", ALC245_FIXUP_HP_X360_MUTE_LEDS),
    +	SND_PCI_QUIRK(0x103c, 0x8c2d, "HP Victus 15-fa1xxx (MB 8C2D)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
     	SND_PCI_QUIRK(0x103c, 0x8c30, "HP Victus 15-fb1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
     	SND_PCI_QUIRK(0x103c, 0x8c46, "HP EliteBook 830 G11", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
     	SND_PCI_QUIRK(0x103c, 0x8c47, "HP EliteBook 840 G11", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
  '';
  kernel = config.boot.kernelPackages.kernel;
  mute-led = pkgs.stdenv.mkDerivation {
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
    (mute-led.overrideAttrs (_: {
      patches = [ alc269-patch ];
    }))
  ];
}
