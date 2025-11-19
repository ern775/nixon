{
  pkgs,
  lib,
  ...
}:
let
  bgImageSection = name: ''
    #${name} {
      background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/${name}.png"));
    }
  '';
in
{
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "sleep 1; hyprlock";
        text = "[l]ock";
        keybind = "l";
      }
      {
        label = "logout";
        action = "sleep 1; hyprctl dispatch exit";
        text = "[e]xit";
        keybind = "e";
      }
      {
        label = "reboot";
        action = "sleep 1; systemctl reboot";
        text = "[r]eboot";
        keybind = "r";
      }
      {
        label = "suspend";
        action = "sleep 1; systemctl suspend";
        text = "s[u]spend";
        keybind = "u";
      }
      {
        label = "hibernate";
        action = "sleep 1; systemctl hibernate";
        text = "[h]ibernate";
        keybind = "h";
      }
      {
        label = "shutdown";
        action = "sleep 1; systemctl poweroff";
        text = "[s]hutdown";
        keybind = "s";
      }
    ];

    style = ''
      * {
        background: none;
      }

      window {
      	background-color: rgba(0, 0, 0, .5);
      }

      button {
        background: rgba(0, 0, 0, .05);
        border-radius: 8px;
        box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .1), 0 0 rgba(0, 0, 0, .5);
        margin: 1rem;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus, button:active, button:hover {
        background-color: rgba(255, 255, 255, 0.2);
        outline-style: none;
      }

      ${lib.concatMapStringsSep "\n" bgImageSection [
        "lock"
        "logout"
        "suspend"
        "hibernate"
        "shutdown"
        "reboot"
      ]}
    '';
  };
}
