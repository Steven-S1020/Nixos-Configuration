# rclone Configuration

{ config, pkgs, lib, username, ... }:

let
  user = config.environment.variables.USER;
in

{
  # Create OneDrive Directory
  systemd.services."create-onedrive-dir" = {
    description = "Create OneDrive mount directory";
    after = [ "setup-rclone-config.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.bash}/bin/bash -c 'mkdir -p /home/${user}/OneDrive'";
  };  
  
  # Mount to File System
  systemd.services."mount-onedrive" = {
    description = "Mount OneDrive for current user";
    after = [ "network-online.target" "create-onedrive-dir.service" ];
    requires = [ "network-online.target" "create-onedrive-dir.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.rclone}/bin/rclone mount OneDrive:/ /home/${user}/OneDrive --config /etc/nixos/Modules/Secrets/rclone.conf --vfs-cache-mode writes; chown -R ${user}:users /home/${user}/OneDrive'";
  }; 
}

