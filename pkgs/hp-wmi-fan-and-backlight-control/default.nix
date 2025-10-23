{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
  kernelModuleMakeFlags,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "hp-wmi-fan-and-backlight-control";
  version = "0.0.2";

  src = fetchFromGitHub {
    owner = "Vilez0";
    repo = "hp-wmi-fan-and-backlight-control";
    rev = "${finalAttrs.version}";
    hash = "sha256-aFxfnm1umDeEkB6hDowtsvfaGgGFltDZAlbFAi+iks0=";
  };

  setSourceRoot = ''
    export sourceRoot=$(pwd)/source
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = kernelModuleMakeFlags ++ [
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "-C"
    "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "M=$(sourceRoot)"
  ];

  enableParallelBuilding = true;

  buildFlags = [ "modules" ];

  installFlags = [ "INSTALL_MOD_PATH=${placeholder "out"}" ];

  installTargets = [ "modules_install" ];

  meta = with lib; {
    description = "Linux kernel module for HP Laptops";
    homepage = "https://github.com/Vilez0/hp-wmi-fan-and-backlight-control";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ern775 ];
    platforms = platforms.linux;
  };
})