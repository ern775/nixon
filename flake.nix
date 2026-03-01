{
  description = "nixon os";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?rev=0182a361324364ae3f436a63005877674cf45efb";
    nixpkgsStable.url = "nixpkgs/nixos-25.11";
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
    custom-nixpkgs = {
      url = "github:ern775/custom-nixpkgs";
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
    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
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
    };
}
