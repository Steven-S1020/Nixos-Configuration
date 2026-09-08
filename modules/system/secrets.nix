{
  den.aspects.system._.secrets.nixos =
    { lib, pkgs, ... }:
    {
        # Enables gnome-keyring secret service and installs GUI to view and manage secrets.
        services.gnome.gnome-keyring.enable = true;
        programs.seahorse.enable = true;

        # Unlocks keyring on login
        security.pam.services.ly.enableGnomeKeyring = true;
    };
}
