{ ... }:
{
  security.rtkit = {
    enable = true;
  };
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      extraConfig.pipewire = {
        "clock-rate" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.allowed-rates" = [
              44100
              48000
              88200
              96000
            ];
            "default.clock.min-quantum" = 256;
            "default.clock.max-quantum" = 1024;
            "default.clock.quantum" = 512;
            "default.clock.quantum-limit" = 8192;
            "default.clock.quantum-floor" = 128;
          };
        };
        # "98-disable-suspension" = {
        #   "context.properties" = {
        #     "session.suspend-timeout-seconds" = 0; # Prevent autosuspend of ALSA nodes, causing xruns and crashes
        #   };
        # };
        "q10-parametric-equalizer" = {
          "context.modules" = [
            {
              name = "libpipewire-module-parametric-equalizer";
              args = {
                "equalizer.filepath" = builtins.toString equalizers/Q10_ParametricEQ.txt;
                "equalizer.description" = "Q10 Parametric EQ Sink";
                "capture.props" = {
                  "node.name" = "Q10 Parametric EQ Input";
                  "filter.smart" = true;
                  "filter.smart.name" = "q10-peq";
                  "filter.smart.target" = {
                    "node.name" = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink";
                  };
                };
                "playback.props" = {
                  "node.name" = "Q10 Parametric EQ Output";
                };
              };
            }
          ];
        };
        "SpaceTravel-parametric-equalizer" = {
          "context.modules" = [
            {
              name = "libpipewire-module-parametric-equalizer";
              args = {
                "equalizer.filepath" = builtins.toString equalizers/SpaceTravel_ParametricEQ.txt;
                "equalizer.description" = "SpaceTravel Parametric EQ Sink";
                "capture.props" = {
                  "node.name" = "SpaceTravel Parametric EQ Input";
                  "filter.smart" = true;
                  "filter.smart.name" = "SpaceTravel-peq";
                  "filter.smart.target" = {
                    "node.name" = "bluez_output.24_09_12_B3_35_A8.1";
                  };
                };
                "playback.props" = {
                  "node.name" = "SpaceTravel Parametric EQ Output";
                };
              };
            }
          ];
        };
      };
      # extraConfig.pipewire-pulse = {
      #   "99-disable-suspension" = {
      #     "pulse.properties" = {
      #       "pulse.idle.timeout" = 0;
      #     };
      #   };
      # };
      wireplumber = {
        enable = true;

        # source: https://wiki.archlinux.org/title/PipeWire#Noticeable_audio_delay_or_audible_pop/crack_when_starting_playback
        extraConfig = {
          "51-disable-suspension" = {
            "monitor.alsa.rules" = [
              {
                matches = [
                  {
                    # Matches all sources
                    "node.name" = "~alsa_input.*";
                  }
                  {
                    # Matches all sinks
                    "node.name" = "~alsa_output.*";
                  }
                ];
                actions.update-props = {
                  "session.suspend-timeout-seconds" = 0;
                };
              }
            ];
            # bluetooth devices
            "monitor.bluez.rules" = [
              {
                matches = [
                  {
                    # Matches all sources
                    "node.name" = "~bluez_input.*";
                  }
                  {
                    # Matches all sinks
                    "node.name" = "~bluez_output.*";
                  }
                ];
                actions.update-props = {
                  "session.suspend-timeout-seconds" = 0;
                };
              }
            ];
          };
          "99-disable-unused-nodes" = {
            "monitor.alsa.rules" = [
              {
                matches = [
                  {
                    "node.name" = "~alsa_output.*HDMI*";
                  }
                  {
                    "node.name" = "alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Mic2__source";
                  }
                ];
                actions.update-props = {
                  "node.disabled" = true;
                };
              }
            ];
          };
        };
      };
    };
  };
}
