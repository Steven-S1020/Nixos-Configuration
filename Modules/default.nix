{ pkgs, config, lib, ... }:

{
  imports = [
    ./Configs
    ./DesktopEnv-Conf
    ./Packages
    ./Home-Manager
    ./System
  ];
}
