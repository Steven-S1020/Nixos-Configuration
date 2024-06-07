{ pkgs, config, lib, ... }:

{
  imports = [
    ./Configs
    ./DesktopEnv-Conf
    ./Packages
    ./VM
    ./home-manager.nix
    ./system.nix
  ];
}
