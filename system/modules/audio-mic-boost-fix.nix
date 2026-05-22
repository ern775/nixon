{ pkgs, lib, ... }:
# NOTE: Probably just need to thoroughly RTFM!
# https://wiki.archlinux.org/title/PipeWire
# https://wiki.archlinux.org/title/WirePlumber
# https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture

let
  # Patch out microphone boost. Done when boost defaults to on and breaks microphone.
  # See: https://community.frame.work/t/microphone-extremely-staticy/15533/12
  pipewire-no-mic-boost =
    let
      volumeLevel = 50;
    in
    pkgs.pipewire.overrideAttrs (og-pkg: {
      name = "${og-pkg.pname}-no-mic-boost";
      separateDebugInfo = false;
      buildCommand = # bash
        ''
          set -euo pipefail

          # Copy original files, for each split-output (`out`, `dev` etc.).
          # TODO: Remove hard coded refrence to pipewire so this function will
          #   work with any package.
          ${lib.concatStringsSep "\n" (
            map (outputName: ''
              echo "Copying output ${outputName}"
              set -x
              cp -a ${pkgs.pipewire.${outputName}} ''$${outputName}
              set +x
            '') og-pkg.outputs
          )}

          set -x

          # Find mic device name in `pw-dump` output

          INFILE=$out/share/alsa-card-profile/mixer/paths/analog-input-internal-mic.conf

          cat $INFILE | \
            ${pkgs.python3}/bin/python -c \
              'import re,sys; print(re.sub("\[Element Capture\]\nswitch = mute\nvolume = merge", "[Element Capture]\nswitch = mute\nvolume = ${toString volumeLevel}", sys.stdin.read()))' | \
               ${pkgs.python3}/bin/python -c \
              'import re,sys; print(re.sub("\[Element Internal Mic Boost\]\nrequired-any = any\nswitch = select\nvolume = merge", "[Element Internal Mic Boost]\nrequired-any = any\nswitch = select\nvolume = 0", sys.stdin.read()))' | \
              ${pkgs.python3}/bin/python -c \
              'import re,sys; print(re.sub("\[Element Int Mic Boost\]\nrequired-any = any\nswitch = select\nvolume = merge", "[Element Int Mic Boost]\nrequired-any = any\nswitch = select\nvolume = 0", sys.stdin.read()))' > \
              tmp.conf

          # Ensure file changed (something was replaced)
          ! cmp tmp.conf $INFILE
          chmod +w $INFILE
          cp tmp.conf $INFILE

          set +x
        '';
    });
in
{
  services.pipewire = {
    package = pipewire-no-mic-boost;
    wireplumber.package = pkgs.wireplumber.override { pipewire = pipewire-no-mic-boost; };
  };
}