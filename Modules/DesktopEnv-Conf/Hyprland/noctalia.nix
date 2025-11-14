{
  pkgs,
  inputs,
  ...
}:

{
  # Install Package
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${system}.default
  ];

  home-manager.users.steven = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell = {
      enable = true;
    };
  };
}
