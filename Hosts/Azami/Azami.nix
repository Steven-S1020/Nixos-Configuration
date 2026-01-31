{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Main Configurations
    ../../Modules

    # Home-Manager NixOS Module from Flake, enables home-manager
    inputs.home-manager.nixosModules.default

    # Azami Hardware-Configuration
    ./hardware-configuration.nix
  ];

  # System Specific #
  ###################
  environment.variables = {
    username = "steven";
  };

  networking.hostName = "Azami"; # Define your hostname.

  # Enable DE Configurations:
  GNOME.enable = true;
  hyprland.enable = true;

  programs.steam.enable = true;

  # System Specific Packages
  environment.systemPackages = with pkgs; [
    surface-control
    auto-cpufreq
  ];

  # Stylix Specific #
  ###################
  stylix = {
    fonts.sizes = {
      applications = 8;
      desktop = 10;
      popups = 10;
      terminal = 8;
    };
  };

}
