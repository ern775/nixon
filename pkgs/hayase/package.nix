{
  lib,
  fetchurl,
  makeWrapper,
  appimageTools,
}:
appimageTools.wrapType2 rec {
  pname = "hayase";
  version = "6.4.23";

  src = fetchurl {
    url = "https://github.com/hayase-app/ui/releases/download/v${version}/linux-hayase-${version}-linux.AppImage";
    hash = "sha256-lP1F1jFXenFDyLX04YZZ00KhG21LUU2OaI0OvHxpgNo=";
  };

  nativeBuildInputs = [ makeWrapper ];

  extraInstallCommands =
    let
      contents = appimageTools.extractType2 { inherit pname version src; };
    in
    ''
      mkdir -p "$out/share/applications"
      mkdir -p "$out/share/lib/hayase"
      cp -r ${contents}/{locales,resources} "$out/share/lib/hayase"
      cp -r ${contents}/usr/* "$out"
      cp "${contents}/hayase.desktop" "$out/share/applications/"
      # https://github.com/ThaUnknown/miru/issues/562
      # Hayase does not work under wayland currently, so force it to use X11
      wrapProgram $out/bin/hayase --set ELECTRON_OZONE_PLATFORM_HINT x11
      substituteInPlace $out/share/applications/hayase.desktop --replace 'Exec=AppRun' 'Exec=hayase'
    '';

  meta = {
    description = "Stream anime torrents, real-time with no waiting for downloads";
    homepage = "https://miru.watch";
    license = lib.licenses.bsl11;
    maintainers = with lib.maintainers; [ ern775 ];
    mainProgram = "hayase";

    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];

    longDescription = ''
      A pure JS BitTorrent streaming environment, with a built-in list manager.
      Imagine qBit + Taiga + MPV, all in a single package, but streamed real-time.
      Completely ad free with no tracking/data collection.

      This app is meant to feel look, work and perform like a streaming website/app,
      while providing all the advantages of torrenting, like file downloads,
      higher download speeds, better video quality and quicker releases.

      Unlike qBit's sequential, seeking into undownloaded data will prioritise downloading that data,
      instead of flat out closing MPV.
    '';
  };
}