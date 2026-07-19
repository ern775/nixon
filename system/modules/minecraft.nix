{ pkgs, inputs, ... }:
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.fabric = {
      enable = true;
      autoStart = false;

      package = pkgs.fabricServers.fabric.override {
        loaderVersion = "0.19.3";
        jre_headless = pkgs.openjdk25_headless;
      };
      serverProperties = {
        online-mode = false;
      };

      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {
            Fabric-API = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/lVXlbH4w/fabric-api-0.155.2%2B26.2.jar";
              hash = "sha256-1lGMdwAky+ilViSPFvzbuRxqYvUCJ6bDuugZBRHiwbg=";
            };
            Lithium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/UPNexAfy/lithium-fabric-0.25.2%2Bmc26.2.jar";
              hash = "sha256-dYjUp2mJSY9W4R5jorEXD/9Hbo2cSqyU4xCz59tGng8=";
            };
            Cloth-Config-API = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/9s6osm5g/versions/Nv3xnWXd/cloth-config-26.2.155.jar";
              hash = "sha256-3vS+djnNZnBPfjBNZY6g9r9JD7Sm6qLb8Y7Cw5mdY0k=";
            };
          }
        );
      };
    };
  };
}
