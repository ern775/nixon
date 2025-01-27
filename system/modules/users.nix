{pkgs, ...}: {
  users.users.eren = {
    isNormalUser = true;
    description = "Eren";
    extraGroups = ["networkmanager" "wheel" "gamemode"];
    shell = pkgs.zsh;
  };
}
