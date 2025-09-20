{
  security.sudo.extraRules = [
    {
      # allow wheel group to run nixos-rebuild without password
      groups = [ "wheel" ];
      commands =
        let
          currentSystem = "/run/current-system/sw";
        in
        [
          {
            command = "${currentSystem}/bin/nixos-rebuild";
            options = [
              "SETENV"
              "NOPASSWD"
            ];
          }
          {
            command = "${currentSystem}/bin/nix-collect-garbage";
            options = [
              "SETENV"
              "NOPASSWD"
            ];
          }
        ];
    }
  ];
}
