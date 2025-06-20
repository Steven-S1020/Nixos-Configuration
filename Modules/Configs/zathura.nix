# zathura Configuration

{ lib, ... }:

{
  home-manager.users.steven = {
    programs.zathura = {

      enable = true;

      options = {
        highlight-color = lib.mkForce "#ffffff";
        highlight-active-color = lib.mkForce "#ffffff";
        highlight-transparency = lib.mkForce 1;
      };
    };
  };
}
