{ pkgs, config, lib, ... }:

{
  imports = [
    ./Configs
    ./DesktopEnv-Conf
    ./Packages
    ./VM
    ./Home-Manager
    ./System
  ];
}
