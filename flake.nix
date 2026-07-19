{
  description = "nixon os";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgsStable.url = "nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nero-umu = {
      url = "github:ern775/Nero-umu";
      flake = false;
    };
    # dopamine = {
    #   url = "https://github.com/digimezzo/dopamine/releases/download/v3.0.2/Dopamine-3.0.2.AppImage";
    #   flake = false;
    # };
    nix-sweep = {
      url = "github:jzbor/nix-sweep";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix-index-database = {
    #   url = "github:nix-community/nix-index-database";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    custom-nixpkgs = {
      url = "path:/home/eren/Git-Projects/custom-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dw-proton = {
      url = "github:imaviso/dwproton-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # zen-browser = {
    #   url = "github:0xc000022070/zen-browser-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # nix-alien = {
    #   url = "github:thiagokokada/nix-alien";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    tuxov = {
      url = "github:TUXOV/hp-wmi-fan-and-backlight-control";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    victus-tui = {
      url = "path:/home/eren/Git-Projects/my-hp-wmi-control-panel-tui";
      flake = false;
    };
    # nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    hyprland.url = "github:hyprwm/Hyprland";
    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-v5 = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./system/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        eren = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit self inputs; };
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [
            ./home
          ];
        };
      };
      packages.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux;
    };
}
