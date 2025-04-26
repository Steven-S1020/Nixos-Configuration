{ pkgs, ... }:

let
  tomlFormat = pkgs.formats.toml { };
  tomlContent = tomlFormat.generate "mkdev-config.toml" {

    recipe_dir = "/etc/nixos/Assets/Mkdev-Recipes";

    subs = {
      day = "date +%d";
      dir = "mk::dir";
      month = "date +%m";
      pc_name = "hostname --fqdn";
      user = "whoami";
      year = "date +%Y";
    };
  };
in
{
  home-manager.users.steven = {
    xdg.configFile."mkdev/config.toml".source = tomlContent;
  };
}
