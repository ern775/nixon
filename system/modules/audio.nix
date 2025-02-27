{pkgs, ...}: {
  services = {
    pipewire = {
      # audio.enable = true;
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      extraConfig.pipewire = {
        "10-clock-rate" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.allowed-rates" = [48000 96000];
            "default.clock.min-quantum" = 512;
            "default.clock.max-quantum" = 8192;
            "default.clock.quantum" = 512;
            "default.clock.quantum-limit" = 8192;
            "default.clock.quantum-floor" = 128;
          };
        };
      };
      wireplumber = {
        enable = true;
        
        # source: https://wiki.archlinux.org/title/PipeWire#Noticeable_audio_delay_or_audible_pop/crack_when_starting_playback
        configPackages = [
          (pkgs.writeTextDir
            "share/wireplumber/wireplumber.conf.d/51-disable-suspension.conf" ''
              monitor.alsa.rules = [
                {
                  matches = [
                    {
                      # Matches all sources
                      node.name = "~alsa_input.*"
                    },
                    {
                      # Matches all sinks
                      node.name = "~alsa_output.*"
                    }
                  ]
                  actions = {
                    update-props = {
                      session.suspend-timeout-seconds = 0
                    }
                  }
                }
              ]
              # bluetooth devices
              monitor.bluez.rules = [
                {
                  matches = [
                    {
                      # Matches all sources
                      node.name = "~bluez_input.*"
                    },
                    {
                      # Matches all sinks
                      node.name = "~bluez_output.*"
                    }
                  ]
                  actions = {
                    update-props = {
                      session.suspend-timeout-seconds = 0
                    }
                  }
                }
              ]
            '')
        ];
      };
    };
  };
}
