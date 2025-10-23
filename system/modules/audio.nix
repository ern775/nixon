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
            "default.clock.quantum-floor" = 256;
          };
        };
        "switch-on-connect" = {
          "pulse.cmd" = [
            {
              "cmd" = "load-module";
              "args" = "module-switch-on-connect";
            }
          ];
        };
        "Speaker-parametric-equalizer" = {
          "context.modules" = [
            {
              name = "libpipewire-module-parametric-equalizer";
              args = {
                "equalizer.filepath" = builtins.toString equalizers/Speaker_ParametricEQ.txt;
                "equalizer.description" = "Speaker Parametric EQ Sink";
                "capture.props" = {
                  "node.name" = "Speaker Parametric EQ Input";
                  "media.class" = "Audio/Sink";
                  "audio.position" = [
                    "FL"
                    "FR"
                  ];
                  "filter.smart" = true;
                  "filter.smart.name" = "Speaker-peq";
                  "filter.smart.target" = {
                    "node.name" = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink";
                  };
                  "node.dont-fallback" = false;
                  "node.linger" = false;
                  # "node.exclusive" = true;
                  # "node.autoconnect" = true;
                  # "node.passive" = true;
                  # "priority.session" = 1001;
                };
                "playback.props" = {
                  "node.name" = "Speaker Parametric EQ Output";
                  "audio.position" = [
                    "FL"
                    "FR"
                  ];
                  "node.passive" = true;
                  # "stream.dont-remix" = true;
                  # "node.suspend-on-idle" = true;
                  # "node.want-driver" = false;
                  "node.dont-fallback" = true;
                  "node.linger" = true;
                  "target.object" = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink";
                };
              };
            }
          ];
        };
        "Q10-parametric-equalizer" = {
          "context.modules" = [
            {
              name = "libpipewire-module-parametric-equalizer";
              args = {
                "equalizer.filepath" = builtins.toString equalizers/Q10_ParametricEQ.txt;
                "equalizer.description" = "Q10 Parametric EQ Sink";
                "capture.props" = {
                  "node.name" = "Q10 Parametric EQ Input";
                  "media.class" = "Audio/Sink";
                  "audio.position" = [
                    "FL"
                    "FR"
                  ];
                  "filter.smart" = true;
                  "filter.smart.name" = "Q10-peq";
                  "filter.smart.target" = {
                    "node.name" = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Headphones__sink";
                  };
                  "node.dont-fallback" = false;
                  "node.linger" = false;
                  # "node.exclusive" = true;
                  # "node.autoconnect" = true;
                  # "node.passive" = true;
                  # "priority.session" = 1001;
                };
                "playback.props" = {
                  "node.name" = "Q10 Parametric EQ Output";
                  "audio.position" = [
                    "FL"
                    "FR"
                  ];
                  "node.passive" = true;
                  # "stream.dont-remix" = true;
                  # "node.suspend-on-idle" = true;
                  # "node.want-driver" = false;
                  "node.dont-fallback" = true;
                  "node.linger" = true;
                  "target.object" =
                    "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Headphones__sink";
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
                  "media.class" = "Audio/Sink";
                  "audio.position" = [
                    "FL"
                    "FR"
                  ];
                  "filter.smart" = true;
                  "filter.smart.name" = "SpaceTravel-peq";
                  "filter.smart.target" = {
                    "node.name" = "bluez_output.24_09_12_B3_35_A8.1";
                  };
                  "node.dont-fallback" = false;
                  "node.linger" = false;
                  # "node.exclusive" = true;
                  # "node.autoconnect" = true;
                  # "node.passive" = true;
                  # "priority.session" = 1001;
                };
                "playback.props" = {
                  "node.name" = "SpaceTravel Parametric EQ Output";
                  "audio.position" = [
                    "FL"
                    "FR"
                  ];
                  "node.passive" = true;
                  # "stream.dont-remix" = true;
                  # "node.suspend-on-idle" = true;
                  # "node.want-driver" = false;
                  "node.dont-fallback" = true;
                  "node.linger" = true;
                  "target.object" = "bluez_output.24_09_12_B3_35_A8.1";
                };
              };
            }
          ];
        };
      };
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
          "98-disable-unused-nodes" = {
            "monitor.alsa.rules" = [
              {
                matches = [
                  {
                    "node.name" = "~alsa_output.*HDMI*";
                  }
                ];
                actions.update-props = {
                  "node.disabled" = true;
                };
              }
            ];
          };
          # "99-disable-nvidia" = {
          #   "monitor.alsa.rules" = [
          #     {
          #       matches = [
          #         {
          #           "device.vendor.name" = "NVIDIA Corporation";
          #         }
          #       ];
          #       actions.update-props = {
          #         "device.disabled" = true;
          #       };
          #     }
          #   ];
        };
      };
    };
  };
}
