{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    mutableExtensionsDir = true;
    # profiles.default.extensions = with pkgs.vscode-extensions; [
    #   llvm-vs-code-extensions.vscode-clangd
    #   bbenoist.nix
    #   jnoortheen.nix-ide
    #   ms-python.python
    #   ms-python.debugpy
    #   mkhl.direnv
    #   arrterian.nix-env-selector
    # ];
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
    #   "clangd.path" = "${lib.getExe' pkgs.clang-tools "clangd"}";
    #   };
  };
}
