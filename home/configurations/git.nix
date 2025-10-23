{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      user = {
        name = "ern775";
        email = "eren.demir2479090@gmail.com";
      };
    };
  };
}
