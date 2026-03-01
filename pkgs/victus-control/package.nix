{
  stdenv,
  lib,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  glib,
  gtk4,
  wrapGAppsHook4,
  desktop-file-utils,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "victus-control";
  version = "0-unstable-2025-12-12";

  src = fetchFromGitHub {
    owner = "Vilez0";
    repo = "victus-control";
    rev = "3cf7d22921a24adb7fe6e806c912679ef81f8c77";
    hash = "sha256-vpRbDA8gfCDx9NJX4EVqPWa49RAU73ZpHu4Y14C6CvQ=";
  };

  postPatch = ''
    substituteInPlace backend/src/fan.cpp \
      --replace-fail '4500' '10000'
  '';

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    desktop-file-utils
    wrapGAppsHook4
  ];

  buildInputs = [
    glib
    gtk4
  ];

  installPhase = ''
    runHook preInstall
    pwd 
    install -Dm755 "backend/victus-backend" "$out/bin/victus-backend"
    install -Dm755 "frontend/victus-control" "$out/bin/victus-control"
    install -Dm644 "$src/frontend/victus-icon.svg" "$out/share/icons/hicolor/48x48/apps/victus-icon.svg"
    install -Dm644 "$src/frontend/victus-control.desktop" "$out/share/applications/victus-control.desktop"
    install -Dm444 $src/backend/victus-backend.service $out/lib/systemd/system/victus-backend.service
    for f in "$out/lib/systemd/system/"*.service "$out/share/applications/"*.desktop; do
      substituteInPlace "$f" \
        --replace "/usr/bin" "$out/bin"
    done
    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/Vilez0/victus-control";
    description = "Victus Control";
    mainProgram = "victus-control";
    maintainers = with lib.maintainers; [ ern775 ];
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
})
