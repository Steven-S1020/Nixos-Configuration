{
  pkgs,
  ...
}:

{
  users.users.steven = {
    isNormalUser = true;
    description = "Steven";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  home-manager.users.steven = {
    home.stateVersion = "24.05";
  };
}
