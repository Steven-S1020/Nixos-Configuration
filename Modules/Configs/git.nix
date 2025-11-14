# git Configuration

{ ... }:

{
  home-manager.users.steven = {
    programs.git = {

      enable = true;

      settings = {
        user = {
          name = "Steven";
          email = "stevenstokes1020@gmail.com";
        };

        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
      };
    };
  };
}
