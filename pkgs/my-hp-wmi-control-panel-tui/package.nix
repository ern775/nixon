{
  lib,
  rustPlatform,
  fetchFromGitHub,
  inputs,
}:
rustPlatform.buildRustPackage rec {
  pname = "my-hp-wmi-control-panel-tui";
  version = "unstable-2025-11-29";

  src = inputs.victus-tui;

  cargoHash = "sha256-jNi9ongRdayz0ECICNbdpZvh/D4rDWG/RPwllGEsouw=";

  meta = {
    description = "Simple tui with hp-wmi-fan-and-backlight-control under the hood";
    homepage = "https://github.com/berk-efe/my-hp-wmi-control-panel-tui";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ern775 ];
    mainProgram = "my-hp-wmi-control-panel-tui";
  };
}
