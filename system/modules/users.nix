{pkgs, ...}: {
  users.users.eren = {
    isNormalUser = true;
    description = "Eren";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };
}
