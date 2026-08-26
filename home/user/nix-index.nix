{ inputs, ... }:
{
  imports = [ inputs.nix-index-database.homeModules.default ];
  # programs.nix-index-database.comma.enable = true;
  programs.nix-index.enableZshIntegration = false;
  programs.command-not-found.enable = false;
}
