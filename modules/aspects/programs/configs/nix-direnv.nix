{
  den.aspects.programs._.nix-direnv.homeManager = {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      config.hide_env_diff = true;
    };
  };
}
