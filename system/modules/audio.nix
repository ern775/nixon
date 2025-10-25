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
      extraConfig.pipewire =
        {
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
        };
      wireplumber = {
        enable = true;
        # source: https://wiki.archlinux.org/title/PipeWire#Noticeable_audio_delay_or_audible_pop/crack_when_starting_playback
        extraConfig = {
          "disable-suspension" = {
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
          "disable-unused-nodes" = {
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
          "role-based-linking" = {
            # "node.software-dsp.rules" = [
            #   {
            #     matches = [
            #       {
            #         "node.name" = "~alsa_output.*";
            #       }
            #     ];
            #     actions.create-filter.hide-parent = true;
            #   }
            # ];
            "wireplumber.profiles" = {
              main = {
                "node.software-dsp" = "required";
                "filter.sink.smart-equalizer" = "required";
              };
            };
            "wireplumber.settings" = {
              "device.routes.default-sink-volume" = 0.008;
              "device.routes.default-source-volume" = 0.064;
              "node.stream.restore-target" = false;
            };
            "wireplumber.components" =
              let
                mkEqSink =
                  {
                    name,
                    equalizerPath,
                    targetDevice,
                  }:
                  {
                    type = "pw-module";
                    name = "libpipewire-module-parametric-equalizer";
                    provides = "filter.sink.smart-equalizer";
                    arguments = {
                      "equalizer.filepath" = builtins.toString equalizerPath;
                      "equalizer.description" = name + " Sink";
                      "audio.position" = [
                        "FL"
                        "FR"
                      ];
                      "capture.props" = {
                        "node.name" = name + " Input";
                        "media.class" = "Audio/Sink";
                        # "device.intended-roles" = [ "Multimedia" ];
                        # "policy.role-based.target" = true;
                        "filter.smart" = true;
                        "filter.smart.name" = name;
                        # "filter.smart.targetable" = true;
                        "filter.smart.target" = {
                          "node.name" = targetDevice;
                        };
                        # "node.dont-fallback" = true;
                        # "node.linger" = false;
                        # "node.exclusive" = true;
                        # "node.autoconnect" = true;
                        # "node.passive" = true;
                        # "priority.session" = 1001;
                      };
                      "playback.props" = {
                        "node.name" = name + " Output";
                        "node.passive" = true;
                        "media.role" = "DSP";
                        # "stream.dont-remix" = true;
                        # "node.suspend-on-idle" = true;
                        # "node.want-driver" = false;
                        "node.dont-fallback" = true;
                        "node.linger" = true;
                        "target.object" = targetDevice;
                      };
                    };
                  };
              in
              [
                (mkEqSink {
                  name = "Speaker Parametric EQ";
                  equalizerPath = equalizers/Speaker_ParametricEQ.txt;
                  targetDevice = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink";
                })
                (mkEqSink {
                  name = "Q10 Parametric EQ";
                  equalizerPath = equalizers/Q10_ParametricEQ.txt;
                  targetDevice = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Headphones__sink";
                })
                (mkEqSink {
                  name = "Space Travel Parametric EQ";
                  equalizerPath = equalizers/SpaceTravel_ParametricEQ.txt;
                  targetDevice = "bluez_output.24_09_12_B3_35_A8.1";
                })
              ];
          };
          # "disable-nvidia" = {
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
          # };
        };
      };
    };
  };
}
