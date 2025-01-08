{inputs, ...}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "eren" = import ../../home;
    };
    backupFileExtension = "backup";
  };
}