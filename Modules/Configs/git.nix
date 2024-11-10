# git Configuration

{ ... }:

{
  home-manager.users.steven = {
    programs.git = {

      enable = true;

      userName = "Steven";
      userEmail = "stevenstokes1020@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
      };
    };
  };
}
