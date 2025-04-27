{
  description = "nixon os";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgsStable.url = "nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    secrets = builtins.fromJSON (builtins.readFile "~/system/secrets.json");
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs secrets;};
        modules = [
          ./system/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      eren = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit self inputs;};
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./home
        ];
      };
    };
  };
}
