{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  electron,
  makeBinaryWrapper,
}:

buildNpmPackage (finalAttrs: {
  pname = "dopamine";
  version = "3.0.0-preview.39";

  src = fetchFromGitHub {
    owner = "digimezzo";
    repo = "dopamine";
    rev = "v${finalAttrs.version}";
    hash = "sha256-OBpUHb04M3mjDRsx5o5EM9ruMuQeRbgSXbaCtfPzlGI=";
  };

  # buildInputs = [];

  nativeBuildInputs = [ makeBinaryWrapper ];

  env.ELECTRON_SKIP_BINARY_DOWNLOAD = true;

  npmDepsHash = "sha256-T8dI8Lb3RwHWopFvKx/YAp95zdIGPJoCKFwOL+SPCWA=";

  npmPackFlags = [ "--ignore-scripts" ];

  npmFlags = [ "--legacy-peer-deps" ];

  makeCacheWritable = true;

  # NODE_OPTIONS = "--openssl-legacy-provider";

  # npmBuildScript = "npm run electron:linux";

  # buildPhase = ''
  #   runHook preBuild

  #   npm run build:prod
  #   npm exec electron-builder build \
  #     --linux \
  #     --config electron-builder.config.js

  #   runHook postBuild
  # '';

  npmBuildFlags = [
    "-c"
    "production"
  ];

  postBuild = ''
    npm exec electron-builder -- \
      --dir \
      -c.electronDist=${electron.dist} \
      -c.electronVersion=${electron.version}
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    install -Dm644 $src/deployment/AUR/dopamine.desktop -t $out/share/applications
    for size in 16 24 32 48 64 96 128 256 512; do
      install -Dm644 "$src/build/icons/"$size"x"$size".png" "$out/share/icons/hicolor/"$size"x"$size"/apps/dopamine.png"
    done

    runHook postInstall
  '';

  # forceGitDeps = true;

  meta = {
    description = "The audio player that keeps it simple";
    homepage = "https://github.com/digimezzo/dopamine";
    changelog = "https://github.com/digimezzo/dopamine/releases/tag/${finalAttrs.src.rev}";
    license = lib.licenses.gpl3Only;
    mainProgram = "dopamine";
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ ern775 ];
  };
})
