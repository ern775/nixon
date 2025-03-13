{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    # profiles.default.userSettings = {
    #   "nix.serverPath" = "nixd";
    #   "nix.enableLanguageServer" = true;
    #   "nix.serverSettings" = {
    #     "nixd" = {
    #       "formatting" = {
    #         "command" = [
    #           "alejandra"
    #         ];
    #       };
    #       "options" = {
    #         "nixos" = {
    #           "expr" = "(builtins.getFlake \"/home/eren/system\").nixosConfigurations.nixos.options";
    #         };
    #         "home_manager" = {
    #           "expr" = "(builtins.getFlake \"/home/eren/system\").homeConfigurations.\"eren\".options";
    #         };
    #       };
    #     };
    #   };
    #   "explorer.confirmDelete" = false;
    #   "nix.formatterPath" = "alejandra";
    #   "editor.minimap.enabled" = false;
    #   "explorer.confirmDragAndDrop" = false;
    #   "security.workspace.trust.untrustedFiles" = "open";
    #   "git.enableSmartCommit" = true;
    #   "git.confirmSync" = false;
    #   "git.autofetch" = true;
    #   "nix.hiddenLanguageServerErrors" = [
    #     "textDocument/formatting"
    #   ];
    # };
  };
}
