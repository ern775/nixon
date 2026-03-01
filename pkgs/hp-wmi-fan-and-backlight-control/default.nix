{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
  kernelModuleMakeFlags,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "hp-wmi-fan-and-backlight-control";
  version = "0.0.3";

  src = fetchFromGitHub {
    owner = "Vilez0";
    repo = "hp-wmi-fan-and-backlight-control";
    tag = finalAttrs.version;
    hash = "sha256-QTIVw9aoBaDt1XsjIMfUF8Pt/+ct7H1Asb1L6m7Xo7A=";
  };

  postPatch = ''
    sed -i 's@depmod -a@@g' Makefile
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = kernelModuleMakeFlags ++ [
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  enableParallelBuilding = true;

  installFlags = [ "INSTALL_MOD_PATH=$(out)" ];

  meta = with lib; {
    description = "Linux kernel module for HP Laptops";
    homepage = "https://github.com/Vilez0/hp-wmi-fan-and-backlight-control";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ern775 ];
    platforms = platforms.linux;
  };
})
